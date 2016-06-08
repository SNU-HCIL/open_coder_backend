class DocumentationApiController < ApplicationController
  
  private
  def success(result)
    render :json=>{:success=>true, :result=>result}
  end
  
  def failure(message)
    render :json=>{:success=>false, :message=>message}
  end
  
  def assert_ownership(model, id_param="id")
    args = params["args"]
    obj = model.find args[id_param]
    if obj.user == current_user
      true
    else
      failure("this is not your #{model.name}.")
    end
  end
      
  public
  
  def create_project
    args = params["args"]
    prj = Project.create(:name => args["name"], :description=>args["description"], :user=>current_user)
    if !prj.nil?
      success {:id=>prj.id}
    else
      failure("failed")
    end
  end
  
  def change_project_info
  end
  
  def remove_project
    prj = assert_ownership(Project, "id")
    Project.delete(prj.id)
    success({:id=>prj.id})
  end
  
  def create_document
    args = params["args"]
    prj = assert_ownership(Project, "project_id")
    doc = Document.create(:name=>args["name"], :description=>args["description"], :project=> prj)
    if !doc.nil?
      success {:id=>doc.id}
    else
      failure("failed")
    end
  end
  
  def change_document_info
  end
  
  def remove_document
    doc = assert_ownership(Document)
    Document.delete(doc.id)
    success({:id=>doc.id})
  end
  
  def get_user_projects
    success current_user.projects.map do |project|
        {
          :id => project.id, 
          :name => project.name, 
          :description => project.description, 
          :documents => project.documents.map{|doc| {:id=>doc.id, :name=>doc.name, :description=> doc.description} }
        }
    end
  end
  
  def get_document_detail
    doc = assert_ownership(Document)
    success {:memos=>doc.document_detail.memos, :quotes=>doc.document_detail.quotes}
  end
  
  def set_document_detail
    args = params["args"]
    doc = assert_ownership(Document)
    doc.document_detail.update(:memos=>args["memos"], :quotes=>args["quotes"])
  end
  
end
