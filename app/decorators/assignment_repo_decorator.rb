class AssignmentRepoDecorator < Draper::Decorator
  delegate_all

  def avatar_url(size)
    "https://avatars.githubusercontent.com/u/#{user.uid}?v=3&size=#{size}"
  end

  def full_name
    github_repository.full_name
  end

  def github_url
    github_repository.html_url
  end

  def student_login
    student.login
  end

  def student_name
    student.name
  end

  private

  def github_repository
    @github_repository ||= GitHubRepository.new(creator.github_client, github_repo_id).repository
  end

  def student
    @student ||= GitHubUser.new(creator.github_client, user.uid).user
  end

  def user
    @user ||= repo_access.user
  end
end
