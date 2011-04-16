class FingerprintMatchesController < ApplicationController
  # GET /fingerprint_matches
  # GET /fingerprint_matches.xml
  def index
    sort_init 'email_id'
  	sort_update

    @fingerprint_matches = FingerprintMatch.search(params[:search], params[:page], sort_clause, params[:n])	
  	
    
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fingerprint_matches }
    end
  end

  # GET /fingerprint_matches/1
  # GET /fingerprint_matches/1.xml
  def show
    @fingerprint_match = FingerprintMatch.find(params[:id])
    r = Regexp.new(Fingerprint.find_by_id(@fingerprint_match.id).regex)
    @match_string = r.match(@fingerprint_match.email.fulltext)
    	
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fingerprint_match }
    end
  end

  # GET /fingerprint_matches/new
  # GET /fingerprint_matches/new.xml
  def new
    @fingerprint_match = FingerprintMatch.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fingerprint_match }
    end
  end

  # GET /fingerprint_matches/1/edit
  def edit
    @fingerprint_match = FingerprintMatch.find(params[:id])
  end

  # POST /fingerprint_matches
  # POST /fingerprint_matches.xml
  def create
    @fingerprint_match = FingerprintMatch.new(params[:fingerprint_match])

    respond_to do |format|
      if @fingerprint_match.save
        format.html { redirect_to(@fingerprint_match, :notice => 'FingerprintMatch was successfully created.') }
        format.xml  { render :xml => @fingerprint_match, :status => :created, :location => @fingerprint_match }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fingerprint_match.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /fingerprint_matches/1
  # PUT /fingerprint_matches/1.xml
  def update
    @fingerprint_match = FingerprintMatch.find(params[:id])

    respond_to do |format|
      if @fingerprint_match.update_attributes(params[:fingerprint_match])
        format.html { redirect_to(@fingerprint_match, :notice => 'FingerprintMatch was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fingerprint_match.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /fingerprint_matches/1
  # DELETE /fingerprint_matches/1.xml
  def destroy
    @fingerprint_match = FingerprintMatch.find(params[:id])
    @fingerprint_match.destroy

    respond_to do |format|
      format.html { redirect_to(fingerprint_matches_url) }
      format.xml  { head :ok }
    end
  end
end
