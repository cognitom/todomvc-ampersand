gulp = require 'gulp'
jade = require 'gulp-jade'

$ =
  src:    './src/jade/*.jade'
  dist:   './public/'

gulp.task 'jade', ->
  gulp.src $.src
  .pipe jade
    pretty: true
  .pipe gulp.dest $.dist
