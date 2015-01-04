gulp        = require 'gulp'
consolidate = require 'gulp-consolidate'
rename      = require 'gulp-rename'
handlebars  = require 'handlebars' # for dependencies

$ =
  src:    './src/hbs/*.hbs'
  dist:   './public/'

gulp.task 'handlebars', ->
  gulp.src $.src
  .pipe consolidate 'handlebars'
  .pipe rename extname: '.html'
  .pipe gulp.dest $.dist
