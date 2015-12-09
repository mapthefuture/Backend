class SitesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    tour = Tour.find(params[:id])
    @sites = tour.sites
    if @sites
      render "index.json.jbuilder", status: :ok
        # status 200
    else 
      render json: { error: "Either the tour does not exist, or it has no sites to display." },
        status: :unprocessable_entity
          # status 422
    end
  end

  def create
    tour = Tour.find(params[:id])
    if tour && tour.user_id == current_user.id
      @site = tour.sites.create!(site_params)
      render "create.json.jbuilder", status: :created
        # status 201
    else
      render json: { error: "You are not authorized to add a site to this tour." },
        status: :unauthorized
          # status 401
    end
  end

  def create_many
    tour = Tour.find(params[:id])
    if params[:sites]
      binding.pry
      begin
        ActiveRecord::Base.transaction do
          @sites = []
          params[:sites].each do |site|
            site = tour.sites.create!(title: site[:title], description: site[:description], image: site[:image],
                                      audio: site[:audio], latitude: site[:latitude], longitude: site[:longitude],
                                      street: site[:street], city: site[:city], state: site[:state], zip: site[:zip],
                                      country: site[:country])
            @sites.push(site)
          end
        end
      rescue Exception => e 
        @errors = e.message + "No sites were created."
      end
      render "create_many.json.jbuilder"
    else
      render json: { error: "Please provide the appropriate parameters." }, status: :not_acceptable
        # status: 406
    end
  end

  def update
    self.find_tour_by_site
    if @tour.user_id == current_user.id
      @site.update(site_params)
      render "update.json.jbuilder", status: :accepted
        # status 202
    else
      render json: { error: "You are not authorized to modify this site." },
        status: :unauthorized
          # status 401
    end
  end

  def show
    @site = Site.find(params[:id])
    if @site
      render "show.json.jbuilder", status: :ok
        # status 200
    end
  end

  def destroy
    self.find_tour_by_site
    if @tour.user_id == current_user.id
      @site.image_file_name = nil
      @site.audio_file_name = nil
      @site.destroy
      render plain: "The site has been deleted successfully.", status: :accepted
        # status 202
    else
      render json: { error: "You are not authorized to delete this site." },
        status: :unauthorized
          # status 401
    end
  end

  def find_tour_by_site
    @site = Site.find(params[:id])
    if @site
      @tour = Tour.find_by(id: @site.tour_id)
    end
  end

  private

  def site_params
    params.permit(:title, :description, :image, :audio, :latitude, :longitude, :street, :city, :state, :zip, :country)
  end  
end
