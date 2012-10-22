class IdeasController < ApplicationController
  #TODO decide on the final layout for Ideas

  layout 'user'

  # GET /ideas
  # GET /ideas.json
  def index
    @ideas = Idea.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ideas }
    end
  end

  # GET /ideas/1
  # GET /ideas/1.json
  def show
    @idea = Idea.find_by_title(params[:id])
    @Passets = Asset.find_all_by_idea_id(@idea.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @idea }
    end
  end

  # GET /ideas/new
  # GET /ideas/new.json
  def new
    @idea = Idea.new
    @list_id = params[:listid]
    5.times {@idea.assets.build}

    @list = List.where("id = ?", @list_id)
    @ll = @list.first

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @idea }
    end
  end

  # GET /ideas/1/edit
  def edit
    @idea = Idea.find_by_title(params[:id])
    @list_id = @idea.list_id
    5.times {@idea.assets.build}
  end

  # POST /ideas
  # POST /ideas.json
  def create
    @idea = Idea.new(params[:idea])
    @li = List.find_by_id(params[:idea][:list_id])
    @idea.list_id = (params[:idea][:list_id])


    respond_to do |format|
      if @idea.save
        @zz = List.find_by_id(@idea.list_id)
        @zz.updated_at = Time.zone.now
        @zz.save!
        format.html { redirect_to list_path(:id => @li.name), notice: 'Idea was successfully created.' }
        format.json { render json: @idea, status: :created, location: @idea }
      else
        @list_id = params[:idea][:list_id]
        @list = List.where("id = ?", @list_id)
        @ll = @list.first
        format.html { render 'new' }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ideas/1
  # PUT /ideas/1.json
  def update
    @idea = Idea.find(params[:id])
    @li = List.find_by_id(@idea.list_id)

    respond_to do |format|
      if @idea.update_attributes(params[:idea])
        @zz = List.find_by_id(@idea.list_id)
        @zz.updated_at = Time.zone.now
        @zz.save!
        format.html { redirect_to list_path(:id => @li.name), notice: 'Idea was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy

    respond_to do |format|
      format.html { redirect_to ideas_url }
      format.json { head :no_content }
    end
  end
end
