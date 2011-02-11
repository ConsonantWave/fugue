The Art of Fugue, Visualized
===

This web app is devoted to visualizing Johann Sebastian Bach's ["The Art of Fugue"] [1], with no musical notation knowledge required. In the current visualization scheme, horizontal position corresponds to pitch, and vertical note height corresponds to note length. The ultimate goal of this project is to demonstrate how each voice of the various pieces of counterpoint in the Art of Fugue interact through the interaction of sound and visual animation. Multiple visualization schemes are envisioned, along with proper sound playback and other fun goodies. Right now, though, you can just see the output of my MIDI parser.

[1]: http://en.wikipedia.org/wiki/The_Art_of_Fugue

Installation
---

There are two prerequisites for creating your own instance of the site. The first is [MongoDB] [2], which has its own installation instructions so I won't bore you with them here. The other requirement is that a MIDI to CSV converter, called, originally enough, [midicsv] [3]. Download the source at [http://www.fourmilab.ch/webtools/midicsv/midicsv-1.1.tar.gz] [4]. Extract the source, run

  $ make

and copy the executables into somewhere in your $PATH.

[2]: http://www.mongodb.org/
[3]: http://www.fourmilab.ch/webtools/midicsv/
[4]: http://www.fourmilab.ch/webtools/midicsv/midicsv-1.1.tar.gz

Next, grab the web app off of this repository, and run

  $ bundle install

to grab any precious gems you might not already have.

It's time to set up your MongoDB database. You'll need to run the following to make that happen:

  $ rails g mongoid:config
  $ rake db:setup

At this point you'll want to edit config/environments/development.rb and change the MIDI\_DIR to something that actually exists on your system. Put some MIDI files into MIDI\_DIR and run

  $ rake midi:parse

to add them to your database. I use the Art of Fugue MIDI files from the [Werner Icking Music Archive] [5], but go nuts, use whatever you like!

[5]: http://icking-music-archive.org/ByComposer/J.S.Bach.php

TODO
---

* Meaningfully test the MIDI parser
* Rewrite output using Raphael.js
* Animate!
* Get sound working, presumably with SoundManager
