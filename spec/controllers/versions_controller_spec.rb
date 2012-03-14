require 'spec_helper'

describe VersionsController do 

  before(:each) do
    @current_user, @company = login_user
  end
  
  describe "POST#revert" do
    it "should revert the change for an update on the project's name and redirect to back" do
      with_versioning do
        @client = Factory(:client)
        @project = Factory(:project, client: @client, company: @company) 
        
        request.env["HTTP_REFERER"] = project_url(@project) 
        
        name = @project.name
        
        @project.update_attributes(name: "My Shiny New Name Bra")
        post :revert, id: @project.versions.last.id
        
        assigns(:resource).name.should eq(name) 
        @project.reload.name.should eq(name)
        response.should redirect_to(:back)
      end
    end
  end
end
