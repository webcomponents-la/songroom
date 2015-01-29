# Songroom

Songroom is a multi-user cloud Karaoke player that allows a group of people to
create a shared Karaoke queue that is played via an HTML5 Karaoke player on a
separate screen.

## Getting Started

To get started with development, you'll need Grunt, Bower, and Yeoman Polymer
installed:

    npm install -g grunt-cli bower yo generator-polymer

Next you'll need to install NPM and Bower dependencies:

    npm install && bower install

Next you'll want to sign up for [Firebase](https://www.firebase.com/) and create
a test Firebase for yourself to use when you work on the app. Once you've done
that, create a `.env.json` file in the project directory that looks like this:

```javascript
{
  "FIREBASE_ORIGIN":"https://YOUR-FIREBASE.firebaseio.com"
}
```

This will allow you to test locally without interfering with production data.
Once you've done that, you can get a development server going:

    grunt serve

The app will now be running on `localhost:8080`.

### Loading Seed Data

To get the app fully up and running on your own Firebase, you'll need some seed
data. This is provided in the `seed` directory and nested according to its Firebase
location. For instance to load seed data contained in `seed/collections/pub.json`,
open a browser to:

    https://YOUR-FIREBASE.firebaseio.com/collections/pub

Then click the **Import JSON** button and load the `pub.json` file. **This will
replace all data at that location**, so be sure you're not overwriting anything
important.

## Origin Story

So one day I ([@mbleigh](http://twitter.com/mbleigh)) was curious how those Karaoke CDs with the terrible
pixelated graphics worked. I read up and learned about the [CD+G](http://en.wikipedia.org/wiki/CD%2BG)
format and its corresponding digital offspring, MP3+G.Continuous Deployment

My next question was: has someone made a web player for this format? The answer,
as it turned out, was yes, mostly. The [CD+Graphics Magic Player](http://cdgmagic.sourceforge.net/html5_cdgplayer/)
was a JS port of a library for reading the format.

To make a longer story short, I first converted the HTML5 CDG player into a
Polymer Web Component, and then before I knew it started building a Firebase
app around it for a multi-user Karaoke app that would let several people manage
a queue of songs and stream them to any connected device.

Because this project has absolutely nothing to do with my company, [Divshot](https://divshot.com)
and was the result of a weekend night of feverish experimentation, I've decided
to open-source the result and open it up to the Web Components LA community.
Perhaps we can, all together, build the best darn Karaoke experience the world
has ever seen using 100% web technology.

And on that day, we'll sing.

## Continuous Deployment

This project uses Travis CI for continuous deployment to Divshot. Because there
are presently no tests, `master` deploys to the `development` environment, with
`staging` and `production` branches.

## Contributing

This is meant to be a community project, however to maximize both sanity and
learning experiences, we're going to do *everything* via pull requests.

Take a look at the [issues page](https://github.com/webcomponents-la/songroom) for
ideas of things to work on (or submit a new issue for something you want to
work on), then fork, create a topic branch, and submit a pull request.

We'll do our best to do code reviews and not only help get the features shipped
but help teach more about how to do Web Components apps right.

## License

The MIT License (MIT)

Copyright (c) 2014 Michael Bleigh

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

**Note:** `app/elements/cdg-canvas/cdg-canvas.js` file is licensed separately
under the terms of the GPL.