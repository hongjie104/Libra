/*
Copyright (c) 2008 EverythingFlex.com.
    http://code.google.com/p/everythingflexairlib/

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

package com.everythingflex.air.managers
{
    import flash.desktop.NativeApplication;
    import flash.desktop.Updater;
    import flash.events.Event;
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;
    import flash.net.URLRequest;
    import flash.net.URLStream;
    import flash.utils.ByteArray;
    
    import mx.controls.Alert;
    import mx.core.FlexGlobals;
    import mx.events.CloseEvent;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    import mx.rpc.http.HTTPService;
    
    public class UpdateManager
    {
       /**
        *  @private
        *  URL of the remote version.xml file
        */
        private var versionURL:String;
        /**
        *  @private
        *  stores the applicationDescriptor
        */
        private var appXML:XML = NativeApplication.nativeApplication.applicationDescriptor;
        /**
        *  @private
        *  stores the Namespace property of the applicationDescriptor
        */
        private var ns : Namespace = appXML.namespace();
        /**
        *  @public
        *  stores the version property of the Namespace
        */
        [Bindable]
        public var currentVersion:String = appXML.ns::versionNumber;
        /**
        *  @public
        *  stores the version property of the remote version.xml file
        */
        private var version:XML;
        /**
        *  @public
        *  used in the updating process
        */
        private var urlStream:URLStream = new URLStream();
        /**
        *  @public
        *  used in the updating process
        */
        private var fileData:ByteArray = new ByteArray();
        /**
        *  Constructor.
        */
        public function UpdateManager(versionURL:String,
                                      autoCheck:Boolean=true):void{
            this.versionURL = versionURL;
            if(autoCheck)loadRemoteFile();
        }
        /**
        *  @private
        *  get the remote version.xml file
        */
        private function loadRemoteFile():void{
            var http:HTTPService = new HTTPService();
            http.url = this.versionURL;
            http.useProxy=false;
            http.method = "GET";
            http.resultFormat="xml";
            http.addEventListener(ResultEvent.RESULT,testVersion);
            http.addEventListener(FaultEvent.FAULT,versionLoadFailure);
            http.send();
        }
        /**
        *  @public
        *  test the currentVersion against the remote version file and
        *  either alert     the user of
        *  an update available or force the update, if no update available, 
        *  alert user when showAlert is true
        */
        public function checkForUpdate(showAlert:Boolean=true):Boolean{
            if(version  ==  null){
                this.loadRemoteFile();
                return true;
            }
            if((currentVersion != version.@version)&&version.@forceUpdate == true){
                Alert.show("There is an required update available,\nplease click Yes to " + 
                           "get it now, or No to cancel and close the application. \n\nDetails:\n" + version.@message, 
                         "Choose Yes or No", 3, null, alertClickHandlerForce);
            }else if(currentVersion != version.@version){
                Alert.show("There is an update available,\nwould you like to " + 
                           "get it now? \n\nDetails:\n" + version.@message, 
                         "Choose Yes or No", 3, null, alertClickHandlerChoice);
            }else{
                if(showAlert)Alert.show("There are no new updates available", "NOTICE");
            }
            return true;
        }
        /**
        * @public
        * test the currentVersion against the remote version file and 
        * either alert the user of
        * an update available or force the update
        */
        private function testVersion(event:ResultEvent):void{
            version = XML(event.result);
            if((currentVersion != version.@version)&&version.@forceUpdate == true){
                Alert.show("There is an required update available,\nplease click Yes to " + 
                           "get it now, or No to cancel and close the application. \n\nDetails:\n" + version.@message, 
                         "Choose Yes or No", 3, null, alertClickHandlerForce);
            }else if(currentVersion != version.@version){
                Alert.show("There is an update available,\nwould you like to " + 
                           "get it now? \n\nDetails:\n" + version.@message, 
                         "Choose Yes or No", 3, null, alertClickHandlerChoice);

            }
        } 
		/**
		* @private
        * Alert user if the version.xml file can't be loaded
        */
        private function versionLoadFailure(event:FaultEvent):void{
            Alert.show("Failed to load version.xml file from "+ 
            this.versionURL,"ERROR");
        }
        /**
		* @private
        * handle the user's Alert Force window decission
        */
        private function alertClickHandlerForce(event:CloseEvent):void {
            if (event.detail==Alert.YES){
                getUpdate();
            } else {
            	//mx.core.Application.application.nativeWindow.close();
				FlexGlobals.topLevelApplication.nativeWindow.close();
            }
        }
        /**
		* @private
        * handle the user's Alert Choice window decission
        */
        private function alertClickHandlerChoice(event:CloseEvent):void {
            if (event.detail==Alert.YES){
                getUpdate();
            }
        }
        /**
		* @private
        * get the new version from the remote server
        */
        private function getUpdate():void{
            var urlReq:URLRequest = new URLRequest(version.@downloadLocation);
            urlStream.addEventListener(Event.COMPLETE, loaded);
            urlStream.load(urlReq);
        }
        /**
		* @private
        * read in the new AIR package
        */
        private function loaded(event:Event):void {
            urlStream.readBytes(fileData, 0, urlStream.bytesAvailable);
            writeAirFile();
        }
        /**
		* @private
        * write the newly downloaded AIR package to the 
        * application storage directory 
        */
        private function writeAirFile():void {
            var file:File = File.applicationStorageDirectory.resolvePath("Update.exe");
            var fileStream:FileStream = new FileStream();
            fileStream.addEventListener(Event.CLOSE, fileClosed);
            fileStream.openAsync(file, FileMode.WRITE);
            fileStream.writeBytes(fileData, 0, fileData.length);
            fileStream.close();
        }
        /**
		* @private
        * after the write is complete, call the update method on the Updater class
        */
        private function fileClosed(event:Event):void {
            var updater:Updater = new Updater();
            var airFile:File = File.applicationStorageDirectory.resolvePath("Update.exe");
            updater.update(airFile,version.@version);
        }
       
    }
}
