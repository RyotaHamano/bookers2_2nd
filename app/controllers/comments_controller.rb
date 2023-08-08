class CommentsController < ApplicationController
  
  def create
    book = Book.find(params[:book_id])
    comment = book.comments.new(comment_params)
    comment.user_id = current_user.id
    comment.save
    redirect_to request.referer
  end
  
  def destroy
    @book = Book.find(params[:book_id])
    comment = Comment.find(params[:id])
    if current_user.id == comment.user_id
      comment.destroy
      redirect_to book_path(@book.id)
    else
      @user = @book.user
      @comments = Comment.all
      render 'books/book'
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:comment)
  end
  
end
