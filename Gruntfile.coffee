module.exports = (grunt) ->

  grunt.loadNpmTasks 'grunt-jasmine-bundle'
  grunt.loadNpmTasks 'grunt-release'

  grunt.initConfig
    spec:
      unit:
        options:
          minijasminenode:
            showColors: true

  grunt.registerTask 'default', 'spec:unit'
