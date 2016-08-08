import processing.serial.*;

// GET YOUR KEY, SECRET, TOKEN, and TOKENSECRET FROM apps.twitter.com

Serial usbPort;
ConfigurationBuilder cb;
TwitterStream twitterStream;
boolean serialInited;
PApplet context;

void initSerial () {
  println("opening the serial port...");
  try {
    usbPort = new Serial (context, Serial.list()[3], 9600);
    serialInited = true;
  } catch (RuntimeException e) {
    if (e.getMessage().contains("<init>")) {
      println("port in use, trying again later...");
      serialInited = false;
    }
  }
}

void setup() {
  context = this;
  println("listing serial ports");
  println(usbPort.list());
  // ask to open the serial port to the arduino
  initSerial();
  // wait for 2 seconds so the port is fully opened
  delay(2000);
  // send a message to the arduino to make the bird chirp
  usbPort.write('N');
  
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setDebugEnabled(true)
    .setOAuthConsumerKey("****")
    .setOAuthConsumerSecret("****")
    .setOAuthAccessToken("****")
    .setOAuthAccessTokenSecret("****");

  twitterStream = new TwitterStreamFactory(cb.build()).getInstance();
  twitterStream.addListener(listener);
  twitterStream.user();
}

void draw () {
  if (serialInited) {
    // we think the serial port is open
    try {
      // try to read, if it works, the port is open!
      usbPort.read();
    } catch (RuntimeException e) {
      // serial port is closed :(
      println("there was an error using the serial port.");
      serialInited = false;
    }
  } else {
    // serial port is closed, so try to open it
    initSerial();
  }
  delay(150);
}

UserStreamListener listener = new UserStreamListener(){
  public void onStatus(Status status) {
    try {
      String tweet  = "@" + status.getUser().getScreenName() + ": " + status.getText();
      println(tweet);
  
      String myUserName = twitterStream.getScreenName();
      if (status.getText().contains("@" + myUserName)) {
       initSerial();
       usbPort.write('N');
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