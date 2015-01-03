gulp       = require 'gulp'
browserify = require 'browserify'
coffeeify  = require 'coffeeify'
jadeify    = require 'jadeify'
source     = require 'vinyl-source-stream'
buffer     = require 'vinyl-buffer'
streamify  = require 'gulp-streamify'
uglify     = require 'gulp-uglify'
sourcemaps = require 'gulp-sourcemaps'
path       = require 'path'

$ =
  src:  './src/coffee/app.coffee'
  dist: './public/js/'

gulp.task 'browserify', ->
  browserify
    entries: [$.src]
    extensions: ['.js','.coffee','.jade']
    debug: true
  .transform coffeeify
  .transform jadeify
  .bundle()
  .pipe source "#{path.basename $.src, '.coffee'}.js"
  .pipe buffer()
  .pipe sourcemaps.init loadMaps: true
  .pipe uglify()
  .pipe sourcemaps.write './'
  .pipe gulp.dest $.dist
