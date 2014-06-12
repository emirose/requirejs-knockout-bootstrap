module.exports = (grunt) ->

  grunt.initConfig
    meta:
      pkg: grunt.file.readJSON('package.json')
      app: 'app'
      src: 'app/scripts/js'
      lib: 'app/scripts/lib'
      coffee: 'app/scripts/coffee'

    clean: ['<%= meta.src %>', 'specs/**/*.js']

    karma:
      unit:
        configFile: 'karma.conf.js'

    coffeelint:
      options:
        indentation: value: 2, level: "error"
        max_line_length: value: 150, level: "warn"
        no_trailing_whitespace: level: "warn"

    coffee:
      src:
        options: bare: true
        files: [ expand: true, cwd:  '<%= meta.coffee %>', src:  ['**/*.coffee'], dest: '<%= meta.src %>', ext: '.js' ]

      specs:
        options: bare: true
        files: [ expand: true, cwd: 'app/specs', src:  ['**/*.coffee'], dest: 'app/specs', rename: (s, d) -> "app/specs/#{d.replace('coffee','js')}"]

  npmTasks = ['grunt-contrib-coffee', 'grunt-contrib-clean','grunt-coffeelint', 'grunt-karma']

  grunt.loadNpmTasks(task) for task in npmTasks

  registerTasks =
      'default': ['clean', 'coffee', 'karma:unit']


  grunt.registerTask(k, v) for k,v of registerTasks

