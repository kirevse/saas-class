class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    current_params = params
    @ratings = current_params[:ratings]
    session_ratings = session[:ratings]
    to_redirect = false
    if @ratings.nil? and not session_ratings.nil?
      to_redirect = true
      current_params = current_params.merge(:ratings => session_ratings)
    end
    @sort_by = params[:sort_by]
    session_sort_by = session[:sort_by]
    if @sort_by.nil? and not session_sort_by.nil?
      to_redirect = true
      current_params = current_params.merge(:sort_by => session_sort_by)
    end
    if to_redirect
      flash.keep
      redirect_to url_for(current_params)
    end
    conditions = Hash.new
    if not @ratings.nil?
      session[:ratings] = @ratings
      conditions[:rating] = @ratings.keys
    end
    if not @ratings.nil?
      session[:ratings] = @ratings
      conditions[:rating] = @ratings.keys
    end
    sort_by = nil
    if [:title.to_s, :release_date.to_s].include? @sort_by
      session[:sort_by] = @sort_by
      sort_by = @sort_by
    end
    @movies = Movie.find(:all, :conditions => conditions, :order => sort_by)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
