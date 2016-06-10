DOCUMENT_ATTRIBUTES_CHILD = [:id, :name, :description, :num_memos, :num_quotes, :created_at_i, :updated_at_i]

class DocumentationApiController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  
  private
  def success(result)
    render :json=>{:success=>true, :result=>result}
  end
  
  def failure(message)
    render :json=>{:success=>false, :message=>message}
  end
  
  def assert_ownership(model, id_param="id")
    args = params["args"].is_a?(String)? JSON.parse(params["args"]) : params["args"]
    obj = model.find args[id_param]
    if obj.user == current_user
      obj
    else
      failure("this is not your #{model.name}.")
    end
  end
      
  public
  
  def create_project
    args = params["args"].is_a?(String)? JSON.parse(params["args"]) : params["args"]
    prj = Project.create(:name => args["name"], :description=>args["description"], :user=>current_user)
    if !prj.nil?
      success({:id=> prj.id})
    else
      failure("failed")
    end
  end
  
  def change_project_info
  end
  
  def remove_project
    prj = assert_ownership(Project, "id")
    Project.delete(prj.id)
    success({id: prj.id})
  end
  
  def create_document
    args = params["args"]
    prj = assert_ownership(Project, "project_id")
    doc = Document.create(:name=>args["name"], :description=>args["description"], :project=> prj)
    if !doc.nil?
      doc.document_detail.update(:memos_json=>args["memos"], :quotes_json=>args["quotes"])
      doc.reload
      success(doc.as_json(only: DOCUMENT_ATTRIBUTES_CHILD))
    else
      failure("failed")
    end
  end
  
  def change_document_info
  end
  
  def remove_document
    doc = assert_ownership(Document)
    Document.delete(doc.id)
    success({id: doc.id})
  end
  
  def get_user_projects
    success (
      current_user.projects.map do |project|
        project.as_json(only: [:id, :name, :description, :created_at_i, :updated_at_i, :updated_last_document_at_i],
          include: {documents: {only: :id}}
          )
      end
    )
  end

  def get_project_detail
    prj = assert_ownership(Project)
    success(
      prj.as_json(only: [:id, :name, :description, :created_at_i, :updated_at_i], include: {documents: {only: DOCUMENT_ATTRIBUTES_CHILD}})
    )
  end
  
  def get_document_detail
    doc = assert_ownership(Document)
    doc_json = doc.as_json(only: [:id, :name, :description, :created_at_i, :updated_at_i])
    doc_json[:memos] = JSON.parse(doc.document_detail.memos_json)
    doc_json[:quotes] = JSON.parse(doc.document_detail.quotes_json)
    success(doc_json)
  end
  
  def set_document_detail
    args = params["args"]
    doc = assert_ownership(Document)
    doc.document_detail.update(:memos=>args["memos"], :quotes=>args["quotes"])
  end
  
end
