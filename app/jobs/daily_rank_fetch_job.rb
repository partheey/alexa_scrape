class DailyRankFetchJob
  include SuckerPunch::Job

  def perform
    # DailyRankFetchJob.perform_in(1.day)
    begin
      sync_ranks_with_alexa
    rescue Exception => e
      puts e
      DailyRankFetchJob.perform_in(1.hour)
      # ToDo exception mailer
    end
  end

  def sync_ranks_with_alexa
    @websites = Website.all
    ids = @websites.pluck(:id)
    update_with_new_rank
    Website.update(ids, @websites)
  end

  def update_with_new_rank
    @websites = @websites.map { |website| build_hash_for_update(website) }
  end

  def build_hash_for_update(website)
    new_rank = FetchRank.new.get(website.address)
    { rank: new_rank } if new_rank
  end
end
