class ResumesController < ApplicationController
before_action :set_resume, only: [:show]


  def index
  	@resumes = Resume.all
  end

  def new
    @resume = Resume.new
  end

  def create
  	@resume = Resume.new(resume_params)
    if @resume.save
      redirect_to resumes_path, notice: "The resume #{@resume.name} has been uploaded."
      pdf   = Grim.reap( "#{Rails.root}/public" + "#{@resume.attachment}")
      i=0;
      
      pdf.each do |page|
        
           png   = page.save("#{Rails.root}/public" + "#{@resume.attachment}"  + "#{i}.png")

           

      i=i+1

      end
      
    else
      render "new"
    end
    #------------------
# @resume = Resume.new(params[:id])

 # @resume.show

#@resume.attachment = params[:file] # Assign a file like this

#@resume.save!
#@resume.attachment.url # => '/url/to/file.png'
#@resume.attachment.current_path # => 'path/to/file.png'
#@resume.attachment_identifier # => 'file.png'
    
 #    pdf   = Grim.reap(@resume.attachment.current_path)         # returns Grim::Pdf instance for pdf
  #   png   = pdf[1].save('#{Rails.root}/public/uploads/resume/attachment')
 
    #-------------------
  end
def show

end
  


  def destroy
  	@resume = Resume.find(params[:id])
    @resume.destroy
    redirect_to resumes_path, notice:  "The resume #{@resume.name} has been deleted."
  end


 private
  def set_resume
      @resume = Resume.find(params[:id])
    end

  def resume_params
    params.require(:resume).permit(:name, :attachment, :file)
  end
end
