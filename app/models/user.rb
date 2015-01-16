class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :programs, dependent: :destroy

  validate :role, presence: true

  enum role: [:athlete, :trainer]

  after_find :load_role

  def trainer?
    !!self.trainer
  end

  def trainer
    @trainer ||= self.trainer!
  end

  def trainer!
    @trainer = Trainer.where(user_id: self.id).first
  end

  def athlete?
    !!self.athlete
  end

  def athlete
    @athlete ||= self.athlete!
  end

  def athlete!
    @athlete = Athlete.where(user_id: self.id).first
  end

  private

    def load_role
      self.trainer? || self.athlete?
    end

end
