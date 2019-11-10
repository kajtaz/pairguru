class CommentsController < ApplicationController
  before_action :find_movie
  before_action :find_comment, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def create
    @comment = @movie.comments.create(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to movie_path(@movie)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to movie_path(@movie)
    else
      render 'edit'
    end
  end

  def destroy
    @comment.destroy
    redirect_to movie_path(@movie)
  end


  private
  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_movie
    @movie = Movie.find(params[:movie_id])
  end

  def find_comment
    @comment = @movie.comments.find(params[:id])
  end

end
