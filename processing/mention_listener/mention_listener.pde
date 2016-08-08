// GET YOUR KEY, SECRET, TOKEN, and TOKENSECRET FROM apps.twitter.com

ConfigurationBuilder cb = new ConfigurationBuilder();
cb.setDebugEnabled(true)
  .setOAuthConsumerKey("****")
  .setOAuthConsumerSecret("****")
  .setOAuthAccessToken("****")
  .setOAuthAccessTokenSecret("****");

final TwitterStream twitterStream = new TwitterStreamFactory(cb.build()).getInstance();

UserStreamListener listener = new UserStreamListener(){
  public void onStatus(Status status) {
    try {
      String tweet  = "@" + status.getUser().getScreenName() + ": " + status.getText();
      println(tweet);
  
      String myUserName = twitterStream.getScreenName();
      if (tweet.contains("@" + myUserName)) {
       println("OMG A MENTION FROM @" + status.getUser().getScreenName() + "!");
      }
    } catch (TwitterException e) {
      println(e);
    }
}
  
  public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {}
  public void onTrackLimitationNotice(int numberOfLimitedStatuses) {}
  public void onStallWarning(StallWarning sw) {}
  public void onScrubGeo(long userId, long upToStatusId) {}
  public void onException(Exception ex) { ex.printStackTrace(); }
  public void onBlock(User source, User blockedUser) {}
  public void onDeletionNotice(long directMessageId, long userId) {}
  public void onDirectMessage(DirectMessage directMessage) {}
  public void onFavorite(User source, User target, Status favoritedStatus) {}
  public void onFavoritedRetweet(User source, User target, Status favoritedRetweeet) {}
  public void onFollow(User source, User followedUser) {}
  public void onFriendList(long[] friendIds) {}
  public void onQuotedTweet(User source, User target, Status quotingTweet) {}
  public void onRetweetedRetweet(User source, User target, Status retweetedStatus) {}
  public void onUnblock(User source, User unblockedUser) {}
  public void onUnfavorite(User source, User target, Status unfavoritedStatus) {}
  public void onUnfollow(User source, User unfollowedUser) {}
  public void onUserDeletion(long deletedUser) {}
  public void onUserListCreation(User listOwner, UserList list) {}
  public void onUserListDeletion(User listOwner, UserList list) {}
  public void onUserListMemberAddition(User addedMember, User listOwner, UserList list) {}
  public void onUserListMemberDeletion(User deletedMember, User listOwner, UserList list) {}
  public void onUserListSubscription(User subscriber, User listOwner, UserList list) {}
  public void onUserListUnsubscription(User subscriber, User listOwner, UserList list) {}
  public void onUserListUpdate(User listOwner, UserList list) {}
  public void onUserProfileUpdate(User updatedUser) {}
  public void onUserSuspension(long suspendedUser) {}
};

twitterStream.addListener(listener);
twitterStream.user();