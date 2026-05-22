class ReviewsController < ApplicationController
  def create
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
    @review = Review.new(review_params)
    @review.list = @list

    if @review.save
      redirect_to list_path(@list)
    else
      render "lists/show", status: :unprocessable_entity
    end
  end

  def destroy
    @review = Review.find(params[:id])
    list = @review.list
    @review.destroy

    redirect_to list_path(list), status: :see_other
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
