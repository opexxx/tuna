class FingerprintsController < ApplicationController
  # GET /fps
  # GET /fps.xml
# def index
#    @fingerprints = fp.paginate(:per_page => params[:n], :page => params[:page], :order => sort_column + " " + sort_direction)
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @fingerprints }
#    end
#  end


def index
	sort_init 'regex'
	sort_update
	
	@fingerprints = Fingerprint.search(params[:search], params[:page], sort_clause, params[:n])	
	
	respond_to do |format|
		format.html # show.html.erb
		format.xml  { render :xml => @project }
	end
end


  # GET /fps/1
  # GET /fps/1.xml
  def show
    @fingerprint = Fingerprint.find(params[:id])
    @email_matches = []
    @fingerprint.fingerprint_matches.each{ |match| @email_matches << match.email}

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fingerprint }
    end
  end

  # GET /fps/new
  # GET /fps/new.xml
  def new
    @fingerprint = Fingerprint.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fingerprint }
    end
  end

  # GET /fps/1/edit
  def edit
    @fingerprint = Fingerprint.find(params[:id])
  end

  # POST /fps
  # POST /fps.xml
  def create
    name = params[:fingerprint][:name]
    regex = params[:fingerprint][:regex]
    description = params[:fingerprint][:description]
    confidence = params[:fingerprint][:confidence]
    references = params[:fingerprint][:references].split(",")

	puts "name: " + name
	puts "name: " + regex
	puts "name: " + description
	puts "name: " + confidence
	puts "name: " + references.to_s

	x = Hash.new
	x[:name] = name
	x[:regex] = regex
	x[:description] = description
	x[:confidence] = confidence
	x[:references] = references

	puts "X:" + x.inspect
	
    @fingerprint = Fingerprint.new(x)

    respond_to do |format|
      if @fingerprint.save
        flash[:notice] = 'fingerprint was successfully created.'
        format.html { redirect_to(@fingerprint) }
        format.xml  { render :xml => @fingerprint, :status => :created, :location => @fingerprint }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fingerprint.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /fps/1
  # PUT /fps/1.xml
  def update
    @fingerprint = Fingerprint.find(params[:id])

    respond_to do |format|
      if @fingerprint.update_attributes(params[:fp])
        flash[:notice] = 'fingerprint was successfully updated.'
        format.html { redirect_to(@fingerprint) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fingerprint.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /fps/1
  # DELETE /fps/1.xml
  def destroy
    @fingerprint = Fingerprint.find(params[:id])
    @fingerprint.destroy

    respond_to do |format|
      format.html { redirect_to(fingerprints_url) }
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
