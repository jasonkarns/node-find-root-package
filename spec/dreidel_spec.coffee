fs = require('fs')
temp = require('temp').track()
mkdirp = require('mkdirp')
Dreidel = require('../lib/dreidel')

moduleTree = (dir) ->
  mkdirp.sync dir
  fs.writeFileSync "#{dir}/package.json"
  dir


describe "Dreidel", ->
  describe "::findTopPackageJson", ->
    Given -> @tmpBase = temp.mkdirSync()
    Given -> @topDir = "#{@tmpBase}/topProject"

    When -> @packageLocation = Dreidel.findTopPackageJson @startDir

    context "without a root package", ->
      Given -> @startDir = @tmpBase
      Then -> @packageLocation is null

    context "at top", ->
      Given -> @startDir = moduleTree @topDir
      Then -> @packageLocation == @topDir

      context "in plugin", ->
        Given -> @startDir = moduleTree "#{@topDir}/node_modules/lineman-browserify"
        Then -> @packageLocation == @topDir

        context "in nested plugin", ->
          Given -> @startDir = moduleTree "#{@topDir}/node_modules/lineman-browserify/node_modules/lineman-browserify"
          Then -> @packageLocation == @topDir
