## Ember Jeopardy

Prepared for the [Ember.js NYC Meetup](http://www.meetup.com/EmberJS-NYC/events/106490682/)

This is a CSS3-dependent very simple implementation of the grid-based
trivia show, written in [Ember.js](http://emberjs.com) RC1. The
templates are written in [Emblem.js](http://emblemjs.com). 

There's no reliance on databases or anything like that; I just chose
Ember Rails because I'm comfortable with it and wanted more examples of
Ember Rails setups for people to peruse. 

The questions are populated by `config/questions.yml`.

## Live Demo

[Check out the live demo.](http://ember-jeopardy.herokuapp.com)

## Works on

Chrome and Safari. Firefox seems to display well enough but the click
handlers don't seem to be working, possibly due to
[this bug](https://bugzilla.mozilla.org/show_bug.cgi?id=830321).

Also, apparently Chrome might not render some of the tiles on some
machines; not sure how to fix this, so if you have any ideas, please
send them my way. A PR would be great too.

New IE might work but haven't tried it yet.

I also gave Rails 4 a try with this, which was mostly fine, but the live
demo loads a little slowly because the manifest.yml generated when
assets are precompiled is apparently some new format that Heroku can't
make sense of yet, so the production server is compiling/serving all the
assets on the fly. Lame.

## Development

```
git clone https://github.com/machty/ember-jeopardy.git
cd ember-jeopardy
bundle
rails s
```

## Author

Alex Matchneer, 2013.

## License

MIT, do as thou wilt.
