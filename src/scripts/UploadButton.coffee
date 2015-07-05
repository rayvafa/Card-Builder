jQuery(document).ready ($) ->
	$('.hcard-file-upload-button').change (e) ->

		files = this.files

		# no file selected, or no FileReader support
		if (!files.length || !window.FileReader)
			return

		# only image file
		if (/^image/.test( files[0].type))
			reader = new FileReader()
			reader.readAsDataURL(files[0])
			reader.onloadend = () ->
				$('.hcard-preview-portrait').attr("src", this.result)


	$('#hcard-upload-button').click () ->
		$('.hcard-file-upload-button').click()
