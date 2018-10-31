class NotesController < ApplicationController
  def index
    @notes = []
    nots = Note.all.where(user_id: current_user.id)
    nots.each do |n|
      @notes << n
    end
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    if @note.save
      flash[:success] = "Your note is saved successfuly!"
      redirect_to users_notes_path
    else
      flash[:danger] = "Cannot be empty!"
      redirect_to users_notes_path
    end
  end

  def edit
    @note = Note.find(params[:id])
  end

  def show
    @note = Note.find(params[:id])
    render 'edit'
  end

  def destroy
    Note.find(params[:id]).destroy
    flash[:success] = "Note deleted"
    redirect_to users_notes_path
  end

  def update
   @note = Note.find(params[:id])
   if @note.update_attributes(note_params)
     flash[:success] = "Your note saved successfuly!"
   else
     flash[:danger] = "Cannot be empty!"
   end
   redirect_to @note
 end

  private

  def note_params
    params.require(:note).permit(:user_id, :content)
  end
end
