class FingerprintsController < ApplicationController
  # GET /fps
  # GET /fps.xml
# def index
#    @fps = fp.paginate(:per_page => params[:n], :page => params[:page], :order => sort_column + " " + sort_direction)
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @fps }
#    end
#  end


def index
	sort_init 'regex'
	sort_update
	
	@fps = Fingerprint.search(params[:search], params[:page], sort_clause, params[:n])	
	
	respond_to do |format|
		format.html # show.html.erb
		format.xml  { render :xml => @project }
	end
end


  # GET /fps/1
  # GET /fps/1.xml
  def show
    @fp = Fingerprint.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fp }
    end
  end

  # GET /fps/new
  # GET /fps/new.xml
  def new
    @fp = Fingerprint.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fp }
    end
  end

  # GET /fps/1/edit
  def edit
    @fp = Fingerprint.find(params[:id])
  end

  # POST /fps
  # POST /fps.xml
  def create
    @fp = Fingerprint.new(params[:fp])

    respond_to do |format|
      if @fp.save
        flash[:notice] = 'fp was successfully created.'
        format.html { redirect_to(@fp) }
        format.xml  { render :xml => @fp, :status => :created, :location => @fp }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fp.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /fps/1
  # PUT /fps/1.xml
  def update
    @fp = Fingerprint.find(params[:id])

    respond_to do |format|
      if @fp.update_attributes(params[:fp])
        flash[:notice] = 'fp was successfully updated.'
        format.html { redirect_to(@fp) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fp.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /fps/1
  # DELETE /fps/1.xml
  def destroy
    @fp = Fingerprint.find(params[:id])
    @fp.destroy

    respond_to do |format|
      format.html { redirect_to(fps_url) }
      format.xml  { head :ok }
    end
  end
  
    #helper_method :sort_column, :sort_direction

  
  private
  
	  #def sort_column
	  # fp.column_names.include?(params[:sort]) ? params[:sort] : "domain"
	  #end
	  
	 #def sort_direction
	  #  %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
	  #end
end
