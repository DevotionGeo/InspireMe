class ListsController < ApplicationController
  # GET /lists
  # GET /lists.json
  def index
    list_sort_order(params[:so])
    @lists = @mylists
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lists }
    end
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
    @list = List.find_by_name(params[:id])
    list_sort_order(params[:so])
    @Lassets = Asset.find_all_by_list_id(@list.id)
    @ideas = @list.ideas
    @followers = Listing.followers(@list.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @list }
    end
  end

  # GET /lists/new
  # GET /lists/new.json
  def new
    @list = List.new
    list_sort_order(params[:so])
    1.times {@list.assets.build}

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @list }
    end
  end

  # GET /lists/1/edit
  def edit
    @list = List.find_by_name(params[:id])
    list_sort_order(params[:so])
    1.times {@list.assets.build}
  end

  # POST /lists
  # POST /lists.json
  def create
    @list = List.new(params[:list])
    @list.user_id = current_user.id

    respond_to do |format|
      if @list.save
        format.html { redirect_to list_path(:id => @list.name), notice: 'List was successfully created.' }
        format.json { render json: @list, status: :created, location: @list }
      else
        format.html { render action: "new" }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lists/1
  # PUT /lists/1.json
  def update
    @list = List.find_by_id(params[:id])

    respond_to do |format|
      if @list.update_attributes(params[:list])
        format.html { redirect_to list_path(:id => @list.name),  notice: 'List was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list = List.find_by_name(params[:id])
    @list.destroy

    respond_to do |format|
      format.html { redirect_to lists_path, notice: 'List has been deleted' }
      format.json { head :no_content }
    end
  end

end
