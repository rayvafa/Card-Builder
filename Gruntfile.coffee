'use strict'
module.exports = (grunt) ->

	# Load grunt tasks automatically
	require('load-grunt-tasks')(grunt)

	# Time how long tasks take. Can help when optimizing build times
	require('time-grunt')(grunt)

	grunt.initConfig

		config:
			src: 'src'
			dist: 'dist'
			tmp: '.tmp'

	# Compiles Sass to CSS and generates necessary files if requested
		sass:
			hcard_builder:
				files: [
					expand: true
					cwd: '<%= config.src %>/styles/'
					src: ['styles.scss']
					dest: '<%= config.tmp %>/styles'
					ext: '.css'
				]

	# Minification of all css
		cssmin:
			target:
				files:
					'<%= config.dist %>/styles/styles.min.css': [
						'<%= config.tmp %>/styles/styles.css'
					]

	# Copies remaining files to dist
		copy:
			dist:
				files: [
					expand: true
					dot: true
					cwd: '<%= config.src %>'
					dest: '<%= config.dist %>'
					src: [
						'*.{ico,png,txt}'
						'images/*.*'
						'{,*/}*.html'
					]
				,
					expand: true
					dot: true
					flatten: true
					cwd: '.'
					src: ['bower_components/bootstrap-sass/assets/fonts/bootstrap/*.*']
					dest: '<%= config.dist %>/fonts/'
				]

	# Compiles CoffeeScript to JavaScript
		coffee:
			dist:
				files: [
					expand: true
					cwd: '<%= config.src %>/scripts/'
					src: '{,*/}*.{coffee,litcoffee,coffee.md}'
					dest: '<%= config.tmp %>/scripts/'
					ext: '.js'
				]

		uglify:
			build:
				src: [
					'bower_components/jquery/dist/jquery.js'
					'<%= config.tmp %>/scripts/**/*.js'
				]
				dest: '<%= config.dist %>/scripts/scripts.min.js'

	# Empties folders to start fresh
		clean:
			dist: 'dist'
			tmp: '.tmp'

		watch:
			styles:
				files: ['<%= config.src %>/styles/**/*.scss']
				tasks: ['sass', 'cssmin']
				options:
					spawn: false
					debounceDelay: 1000,

	grunt.registerTask "clean-all", [
		"clean"
	]

	grunt.registerTask "watcher", [
		"watch"
	]

	grunt.registerTask "build", [
		"clean"
		"sass"
		"cssmin"
		"coffee"
		"uglify"
		"copy"
	]

	grunt.registerTask "default", ["build"]