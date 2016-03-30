# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# truncated from above to demonstrate additional code to associate uploads
# with posts
#jackUp.on "upload:success", (e, options) ->
#  $("img[data-id='#{options.file.__guid__}']").css(borderColor: "green")
#
#  # read the response from the server
#  asset = JSON.parse(options.responseText)
#  assetId = asset.id
#  # create a hidden input containing the asset id of the uploaded file
#  assetIdsElement = $("<input type='hidden' name='opportunity[asset_ids][]'>").val(assetId)
#  # append it to the form so saving the form associates the created post
#  # with the uploaded assets
#  $(".file-drop").parent("form").append(assetIdsElement)