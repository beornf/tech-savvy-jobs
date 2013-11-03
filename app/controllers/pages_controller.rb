class PagesController < HighVoltage::PagesController
  def show
    if params[:id] == 'home'
      @list = Job.order('date DESC')
      @jobs = @list.page params[:page]
      @total = @list.count
    end
    super
  end
end