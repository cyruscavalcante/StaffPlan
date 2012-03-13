class VersionsController < ApplicationController
  def revert
    @version = Version.find(params[:id])
    # FIXME: Since the object has already passed validation, 
    # I figure it shouldn't be validated again. Note that it also avoids problems when
    # trying to un-delete a user, since we only store a password digest (while validation requires a password)
    @version.reify.save(validate: false)
    redirect_to :back 
  end
end
