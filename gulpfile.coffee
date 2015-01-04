gulp        = require 'gulp'
runSequence = require 'run-sequence'
requireDir  = require 'require-dir'
dir         = requireDir './task'
del         = require 'del'
browserSync = require 'browser-sync'
reload      = browserSync.reload

$ =
  src:  './src/'
  dist: './public/'

gulp.task 'default', (cb) ->
  runSequence 'clean', 'build', cb

gulp.task 'clean', (cb) -> del [$.dist], -> cb()

gulp.task 'build', (cb) ->
  runSequence [
    'browserify'
    'css'
    'handlebars'
    #'jade'
  ], cb

gulp.task 'watch', ->
  browserSync.init
    notify: false
    server: baseDir: $.dist
  o = debounceDelay: 3000
  gulp.watch ["#{$.src}css/**/*"], o, ['css']
  gulp.watch ["#{$.src}hbs/*"], o, ['handlebars']
  #gulp.watch ["#{$.src}jade/**/*"], o, ['jade']
  gulp.watch [
    "#{$.src}coffee/**/*"
    "#{$.src}hbs/component/**/*"
    #"#{$.src}jade/component/**/*"
  ], o, ['browserify']
  gulp.watch [
    "#{$.dist}*.html"
    "#{$.dist}js/**/*.js"
    "#{$.dist}css/**/*.css"
  ], o, reload
