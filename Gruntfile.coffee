module.exports = (grunt) ->
  grunt.initConfig

    jade:
      compile:
        files: [
          cwd: "views",
          src: "**/*.jade",
          dest: "build",
          expand: true,
          ext: ".html" ]

    sass:
      app:
        files:
          'build/assets/stylesheet/style.css': 'assets/stylesheet/style.sass'

    coffeelint:
      app:
        files:
          src: ['assets/**/*.coffee']

    coffee:
      options:
        sourceMap: true
      app:
        files:
          'build/assets/javascript/main.js': ['assets/javascript/**/*.coffee']

    watch:
      jade:
        files: ['views/**/*.jade']
        tasks: ['jade', 'notify:watch']

      coffee:
        files: ['assets/javascript/**/*.coffee']
        tasks: ['coffeelint', 'coffee', 'notify:watch']

      sass:
        files: ['assets/stylesheet/**/*.sass']
        tasks: ['sass', 'notify:watch']

      build:
        files: ['build/assets/stylesheet/**/*.css', 'build/*.html', 'build/assets/javascript/**/*.js']
        options:
          livereload: true

    connect:
      server:
        options:
          port: 3333
          base: 'build'

    open:
      dev:
        path: 'http://localhost:3333/'
        app: 'Google Chrome'

    notify_hooks:
      enabled: true

    notify:
      watch:
        options:
          title: 'Task complete'
          message: 'Build files successfully updated'

      server:
        options:
          title: 'Server started'
          message: 'Server started at http://localhost:3333'

  grunt.loadNpmTasks 'grunt-notify'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-open'
  grunt.loadNpmTasks 'grunt-coffeelint'

  grunt.registerTask 'default', ['sass', 'coffeelint', 'coffee', 'copy']
  grunt.registerTask 'server', ['default', 'connect', 'notify:server', 'open:dev', 'watch']