class JournalsController < ApplicationController
  before_action :set_journal, only: [:show, :edit, :update, :destroy]

  def index
    @journals = Journal.all.order(created_at: :desc)
  end

  def show
    @entries = @journal.entries.order(created_at: :desc)
  end

  def new
    @journal = Journal.new
  end

  def create
    @journal = Journal.new(journal_params)
    
    if @journal.save
      redirect_to @journal, notice: 'Journal was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @journal.update(journal_params)
      redirect_to @journal, notice: 'Journal was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @journal.destroy
    redirect_to journals_url, notice: 'Journal was successfully deleted.'
  end

  private

  def set_journal
    @journal = Journal.find(params[:id])
  end

  def journal_params
    params.require(:journal).permit(:title)
  end
end
