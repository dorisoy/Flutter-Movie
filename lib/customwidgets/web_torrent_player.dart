import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:movie/actions/adapt.dart';

class WebTorrentPlayer extends StatefulWidget {
  final String url;
  WebTorrentPlayer({Key key, @required this.url}) : super(key: key);
  @override
  WebTorrentPlayerState createState() => WebTorrentPlayerState();
}

class WebTorrentPlayerState extends State<WebTorrentPlayer> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: InAppWebView(
          initialData: InAppWebViewInitialData(data: """<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>WebTorrent video player</title>
    <style>
      #output video {        
        width: 100%;
        height:${Platform.isIOS ? '100%' : (Adapt.screenW() * 9 / 16).toString() + 'px'};
        background-color: black;
      }
      #progressBar {
          height: 5px;
          width: 0%;
          background-color: #35b44f;
          transition: width .4s ease-in-out;
      } 
      body{
          margin:0;
          background-color: black;
      }
      body.is-seed .show-seed {
          display: inline;
      }
      body.is-seed .show-leech {
          display: none;
      }
      .show-seed {
          display: none;
      }
      .is-seed #hero {
          background-color: #154820;
          transition: .5s .5s background-color ease-in-out;
      }
      #hero {
          background-color: #black;
      }
    </style>
  </head>
  <body>
    <div id="hero">
      <div id="output">
        <!-- The video player will be added here -->
      </div>
      <!-- Statistics -->
     
    </div>
    <!-- Include the latest version of WebTorrent -->
    <script src="https://cdn.jsdelivr.net/npm/webtorrent@latest/webtorrent.min.js"></script>

    <!-- Moment is used to show a human-readable remaining time -->
    <script src="http://momentjs.com/downloads/moment.min.js"></script>
    
    <script>
    const mediaExtensions = {
  audio: [
    '.aac', '.aif', '.aiff', '.asf', '.dff', '.dsf', '.flac', '.m2a',
    '.m2a', '.m4a', '.mpc', '.m4b', '.mka', '.mp2', '.mp3', '.mpc', '.oga',
    '.ogg', '.opus', '.spx', '.wma', '.wav', '.wv', '.wvp'],
  video: [
    '.avi', '.mp4', '.m4v', '.webm', '.mov', '.mkv', '.mpg', '.mpeg',
    '.ogv', '.webm', '.wmv'],
  image: ['.gif', '.jpg', '.jpeg', '.png']
}
      var torrentId = '${widget.url}'

      var client = new WebTorrent()

      // HTML elements
      var \$body = document.body
      var \$progressBar = document.querySelector('#progressBar')

      // Download the torrent
      client.add(torrentId, function (torrent) {

        // Torrents can contain many files. Let's use the .mp4 file
        var file = torrent.files.find(function (file) {
          return mediaExtensions.video.includes(getFileExtension(file))
        })

        // Stream the file in the browser
        file.appendTo('#output')

        // Trigger statistics refresh
        torrent.on('done', onDone)
        setInterval(onProgress, 500)
        onProgress()

        // Statistics
        function onProgress () {
          // Progress
          var percent = Math.round(torrent.progress * 100 * 100) / 100
          \$progressBar.style.width = percent + '%'

          // Remaining time
          var remaining
          if (torrent.done) {
            remaining = 'Done.'
          } else {
            remaining = moment.duration(torrent.timeRemaining / 1000, 'seconds').humanize()
            remaining = remaining[0].toUpperCase() + remaining.substring(1) + ' remaining.'
          }
        }
        function onDone () {
          \$body.className += ' is-seed'
          onProgress()
        }
      })

    function getFileExtension (file) {
     const name = typeof file === 'string' ? file : file.name
     var index= name.lastIndexOf(".");
     return name.substr(index);
}

      // Human readable bytes util
      function prettyBytes(num) {
        var exponent, unit, neg = num < 0, units = ['B', 'kB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB']
        if (neg) num = -num
        if (num < 1) return (neg ? '-' : '') + num + ' B'
        exponent = Math.min(Math.floor(Math.log(num) / Math.log(1000)), units.length - 1)
        num = Number((num / Math.pow(1000, exponent)).toFixed(2))
        unit = units[exponent]
        return (neg ? '-' : '') + num + ' ' + unit
      }
    </script>
  </body>
</html>"""),
          initialHeaders: {},
          initialOptions: InAppWebViewWidgetOptions(
              androidInAppWebViewOptions:
                  AndroidInAppWebViewOptions(supportZoom: false),
              inAppWebViewOptions: InAppWebViewOptions(
                disableVerticalScroll: true,
                disableHorizontalScroll: true,
                horizontalScrollBarEnabled: false,
                verticalScrollBarEnabled: false,
                debuggingEnabled: true,
              ))),
    );
  }
}
