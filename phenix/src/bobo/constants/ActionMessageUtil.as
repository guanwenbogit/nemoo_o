package bobo.constants {
  import bobo.modules.main.RoomModel;
  import bobo.util.net.CryptoToken;

  import com.netease.nis.fgp.Fgp;

  /**
   * @author sytang
   */
  public class ActionMessageUtil {
    

    public static function createEnterRoomMessage(model:RoomModel,captchaToken:String = "",captchaCode:String = ""):String {
      if (!model) {
        return '';
      }
      
      var token:CryptoToken = new CryptoToken();
      token.gen(model.token);
      
      return JSON.stringify({"userId":model.self.userId,
                             "roomId":model.roomId, 
                             "action":ActionNames.ROOM_ENTER,
                             "token":token.ct,
                             "timestamp":token.time,
                             "random":token.rand,
                             "fp":Fgp.get(),
                             "platform":false ? "pc_client" : "pc",
                             "captchaToken":captchaToken,
                             "captchaCode":captchaCode});
    }
    
    public static function createReconnectMessage(model:Object):String {
      var token:CryptoToken = new CryptoToken();
      token.gen(model.token);
      
      return JSON.stringify({"action":ActionNames.RECONNECT, 
                            "userId": model.selfModel.userId, 
                            "roomId": model.roomId, 
                            "token": token.ct,
                            "timestamp":token.time,
                             "fp":Fgp.get(),
                            "random":token.rand
                            });
    }
    
    public static function createExitRoomMessage(model:Object):String {
      if (!model) {
        return '';
      }
      return JSON.stringify({"userId":model.userId,
                             "action":ActionNames.ROOM_EXIT,
                             "token":null});
    }
    
    public static function createBroadcastMessage(msg:String,content:String, type:String):String {
      if (!msg) {
        return '';
      }
      
      if (msg.length == 0) {
        return '';
      }
      
      return JSON.stringify({"action":type,"message":msg,"type":0,"content":content});
    }
    
    public static function createGroupChatMessage(msg:String, content:String,toUser:String,fly:int = 0,liveId:int = -1):String {
      if (msg.length == 0) {
        return '';
      }
      
      return JSON.stringify({"action":ActionNames.BROADCAST_ROOM, 
                            "message":msg, 
                            "atUserId": toUser, 
                            "type":0,
                            "content":content,
                            "liveId":liveId,
                            "fly":fly});
    }
    
    public static function createSinglecastMessage(msg:String,content:String, toUser:String,liveId:int):String {
      if (!msg || !toUser) {
        return '';
      }
      if (msg.length == 0 || toUser.length == 0) {
        return '';
      }
      
      return JSON.stringify({"action":ActionNames.BROADCAST_SINGLE, 
                            "message":msg, 
                            "targetUserId": toUser, 
                            "content":content,
                            "liveId":liveId,
                            "type":0});
    }
    
    public static function createGiftMessage(id:int, num:int, from:String, to:String):String {
      if (id <= 0) {
        return '';
      }
      if (num <= 0) {
        return '';
      }
      return JSON.stringify({"action":ActionNames.SEND_GIFT,
                            "from":from,
                            "giftId":id,
                            "num":num,
                            "reqNo":0,
                            "to":to});
    }
    
    public static function createRequestInfoMessage(userId:String):String {
      if (!userId || userId.length <= 0) {
        return '';
      }
      return JSON.stringify({"action":ActionNames.USER_INFO, "userId":userId});
    }
    
    public static function createHeartbeat():String {
      var timeStamp:uint = (new Date()).getTime()/1000;
      return JSON.stringify({"t":timeStamp});
    }

    public static function createGiftListMessage():String {
      var platform : String = "pc";
//      if(FirstStepRoomStatusUtil.isPC()){
//        platform = "pc_client";
//      }
      return JSON.stringify({"action":ActionNames.GIFT_LIST, "platform" : platform});
    }
    public static function createUserListMessage(page:int,size:int = 50):String {
      return JSON.stringify({"action":ActionNames.USER_LIST,"page":page,"size":size,"limit":size,"start":page});
    }
    public static function createSelfLocationMessage(size:int = 50):String{
      return JSON.stringify({"action":ActionNames.USER_LIST_LOCATION,"pageSize":size});
    }
    public static function createFreeGiftRequestMessage():String {
      return JSON.stringify({"action":ActionNames.FREE_GIFT, "respNo":0});
    }
    public static function createSendFreeGiftMessage(to:String, num:int,liveId:int):String {
      return JSON.stringify({"action":ActionNames.GIVE_FREE, "to": to, "num":num,"liveId":liveId, "respNo":0});
    }
    public static function createRequestSeatListMessage(page:int, reqNo:int):String {
      return JSON.stringify({"action":ActionNames.SEAT_LIST, "page":page, "reqNo":reqNo});
    }

    public static function createTakeSeatMessage(position:int):String {
      return JSON.stringify({"action":ActionNames.TAKE_SEAT, "position": position});
    }
    
//    public static function createRequestRankList(flag:String, page:int = 0, liveId:int = 0):String {
////      return JSON.stringify({"action":flag, "limit":RankModel.PAGE_LIMIT, "start": page * RankModel.PAGE_LIMIT});
//      return JSON.stringify({"action":flag, "limit": RankModel.PAGE_LIMIT, "start": 0, "liveId":liveId});
//    }
//    public static function createRequestRankList2(flag:String,liveId:int, isLong:Boolean = false):String {
//      return JSON.stringify({"action":flag, "limit":isLong ? RankModel.ITEM_MAX : 8, "start": 0,"roomEventId":liveId});
//    }
    public static function createRefreshCarListMessage():String {
      return JSON.stringify({"action":ActionNames.CAR_LIST, "start": 0, "limit":500});
    }
    public static function createTakeSofaMessage(curWorth:uint, raise:uint, position:uint):String {
      return JSON.stringify({"action":ActionNames.TAKE_SOFA, "curWorth":curWorth, "raise":raise, "position":position});
    }
    public static function createComboTopMessage():String {
      return JSON.stringify({"action":ActionNames.GIFT_COMBO_TOP});
    }
    //==========================================================================
    //  vod message
    //==========================================================================
    public static function createSongsListMessage():String{
      return JSON.stringify({"action":ActionNames.SONG_LIST,"start":0,"limit":500});
    }
    public static function createSongsOrderMessage():String {
      return JSON.stringify({"action":ActionNames.SONG_ORDER_LIST,"start":0,"limit":500});
    }
    public static function createSongRequestMessage(songName:String,aslId:uint = 0, usePackage:int = 0):String{
      return JSON.stringify({"action":ActionNames.REQUEST_SONG,"aslId":aslId,"songName":songName, "usePackage":usePackage});
    }
    public static function createSongAcceptRequestMessage(usoId:uint = 0):String{
      return JSON.stringify({"action":ActionNames.ACCEPT_SONG,"usoId":usoId});
    }
    public static function createSongRefuseMessage(usoId:uint = 0):String{
      return JSON.stringify({"action":ActionNames.REFUSE_SONG,"usoId":usoId});
    }
    public static function createAgreeAllSong():String {
      return JSON.stringify({"action":ActionNames.ACCEPT_ALL_SONG});
    }
    public static function createRejectAllSong():String {
      return JSON.stringify({"action":ActionNames.REFUSE_ALL_SONG});
    }
    public static function createForbidOrderMessage(forbid:Boolean):String {
      return JSON.stringify({"action":ActionNames.FORBID_ORDER_SONG,"forbid" : forbid});
    }
    public static function createFollowMessage(userId:String, reqNo:uint):String {
      return JSON.stringify({"action":ActionNames.FOLLOW, "followId":userId, "reqNo":reqNo});
    }
    public static function createUnfollowMessage(userId:String, reqNo:uint):String {
      return JSON.stringify({"action":ActionNames.UNFOLLOW, "followId":userId, "reqNo":reqNo});
    }
    public static function createApproveManagerMessage(userId:String):String {
      return JSON.stringify({"action":ActionNames.APPROVE_ROOM_MANAGER, "targetUserId":userId});
    }
     public static function createUNApproveManagerMessage(userId:String):String {
      return JSON.stringify({"action":ActionNames.UNAPPROVE_ROOM_MANAGER, "targetUserId":userId});
    }
    public static function createRoomManagerMessage(userId:String,type:int, reqNo:uint):String {
      return JSON.stringify({"action":ActionNames.ROOM_MANAGER, "targetUserId":userId,"type":type, "reqNo":reqNo});
    }
    public static function createManagersMessage(page:int = 0,size:int = 50):String {
      return JSON.stringify({"action":ActionNames.LISTMANGER,"limit":size,"start":page,"page":page,"size":size});
    }
    public static function createKickMessage(userId:String):String{
      return JSON.stringify({"action":ActionNames.KICK_USER,"userId":userId});
    }
    public static function createGagMessage(userId:String):String{
      return JSON.stringify({"action":ActionNames.GAG_USER,"userId":userId,"type":1});
    }
    public static function createUngagMessage(userId:String):String{
      return JSON.stringify({"action":ActionNames.GAG_USER,"userId":userId,"type":0});
    }
    public static function createGetPackageListMessage(userId:String):String {
      return JSON.stringify({"action":ActionNames.PACKAGE_LIST});
    }

    public static function createFirstLoginMessage(nick:String, gender:int, time:Number):String {
      return JSON.stringify({"action":ActionNames.USER_EDIT, "nick":nick, "birthday": time, "sex":gender});
    }

    public static function createGameParticipants():String {
      return JSON.stringify({"action":ActionNames.GAME_PARTICIPANTS});
    }

    public static function createSendLetterMessage(userId:String,message:String):String {
      return JSON.stringify({"action":ActionNames.SEND_MSG,"toUserId":userId,"message":message});
    }
    public static function createFlyMessage(message:String,content:String, flyType : int = 0):String {
      return JSON.stringify({"action":ActionNames.FLY,"message":message,content:content, flyType:flyType});
    }
    public static function createEditUserNickMessage(nick:String):String {
      return JSON.stringify({"action":ActionNames.EDIT_NICK,"nick":nick});
    }
    public static function createValidateMessage(nick:String):String {
      return JSON.stringify({"action":ActionNames.VALIDATE_NICK,"nick":nick});
    }
    
    public static function createUpdateTaskMessage(type:String):String {
      return JSON.stringify({"action":ActionNames.ROOKIE_GUIDE, "type":type});
    }
    
    public static function createSetEffectLevelMessage(level:int):String {
      return JSON.stringify({"action":ActionNames.SET_EFFECT_LEVEL, "level":level});      
    }
    public static function createForbidLiveMessage():String {
      return JSON.stringify({"action":ActionNames.FORBID_LIVE});      
    }
    public static function createUnbanLiveMessage():String {
      return JSON.stringify({"action":ActionNames.UNBAN_LIVE});      
    }

    public static function createShareRoomMessage(roomType:String):String {
      return JSON.stringify({"action":ActionNames.ROOKIE_GUIDE, "type":"SHARE_ROOM", "roomType":roomType});
    }
    public static function createRookieGuideMessage(type:String):String {
      return JSON.stringify({"action":ActionNames.ROOKIE_GUIDE, "type":type});
    }

    public static function createTakeSofaKing(skId : Number, cost : int):String {
      return JSON.stringify({"action":ActionNames.SOFA_KING_TAKE, "skId":skId, "cost":cost});
    }
    
    public static function createSendQuestion(skId : Number, question : String):String {
      return JSON.stringify({"action":ActionNames.SOFA_KING_QUES, "skId":skId, "question":question});
    }
    
    public static function createGetActivityMessage():String {
      return JSON.stringify({"action":ActionNames.ACTIVITY_INDEX});
    }
    
    public static function createSofaKingBoard(start:int,limit:int):String {
      return JSON.stringify({"action": ActionNames.SOFAKINGBOARD,"start":start,"limit":limit});
    }
    
    public static function createSofaKing(duration : int):String {
      return JSON.stringify({"action": ActionNames.SOFA_KING_CREATE, "duration": duration});
    }
    
    public static function answerSofaKing():String {
      return JSON.stringify({"action": ActionNames.SOFA_KING_ANSWER});
    }
    
    public static function createGuessTopicStartMessage(title:String, answer:int):String {
      return JSON.stringify({"action":ActionNames.GUESS_TOPIC_START, "title":title, "answer": answer});
    }

//    public static function createGuessTopicList(page:int):String {
//      return JSON.stringify({"action":ActionNames.GUESS_TOPIC_LIST, "start":page * TrueFalseHistoryItemContainer.ITEM_NUM, "limit": TrueFalseHistoryItemContainer.ITEM_NUM});
//    }

    public static function createRequest520Message():String {
      return JSON.stringify({"action":ActionNames.LOVE_ACTIVITY_RANK});
    }

    public static function createYellMessage(message:String,content:String, usePackage:int = 0, type: int = 0):String {
      return JSON.stringify({"action":ActionNames.YELL,"message":message,"content":content, "usePackage":usePackage, type:type});;
    }
    public static function createFreeGiftRankDiff(anchorId : String):String {
      return JSON.stringify({"action":ActionNames.FREE_GIFT_RANK_DIFF, "anchorId" : anchorId});
    }
    
    public static function createVipGiftRankDiff(anchorId : String):String {
      return JSON.stringify({"action":ActionNames.VIP_GIFT_RANK_DIFF, "anchorId" : anchorId});
    }

    public static function createActivityAnchorRank(activityId:int):String {
      return JSON.stringify({"action":ActionNames.ACTIVITY_ANCHOR_RANK, "activityId" : activityId});
    }
    public static function createActivityUserRank(activityId:int):String {
      return JSON.stringify({"action":ActionNames.ACTIVITY_ROOMUSER_RANK, "activityId" : activityId});
    }
    public static function createWorldCupCountry(userIds:String):String {
      return JSON.stringify({"action":ActionNames.WORLDCUP_COUNTRY, "userIds" : userIds});
    }
    public static function createGuardListMessage():String {
      return JSON.stringify({"action":ActionNames.GUARD_LIST});
    }

    public static function createGuardBuyMessage(unit:String, quantity:int):String {
      return JSON.stringify({"action":ActionNames.GUARD_BUY, "unit":unit, "quantity":quantity, "itemId":27});
    }
    
    public static function createPreAcitiviesMessage():String {
      return JSON.stringify({"action":ActionNames.COMING_ACTIVITIES});
    }
    
    public static function createCurrentActivitiesMessage():String {
      return JSON.stringify({"action":ActionNames.CURRENT_ACTIVITIES});
    }
    public static function createLivingDashBoardMessage():String {
      return JSON.stringify({"action":ActionNames.HALL_DASH_BOARD});
    }
    public static function createGuardWeekList():String {
      return JSON.stringify({"action": ActionNames.GUARD_CURRENT_RANK, "start": 0, "limit": 100});
    }

    public static function createLivingNotiveMessage(type:int):String {
      return JSON.stringify({"action": ActionNames.HALL_NOTICE, type:type});
    }

    public static function createFollowLivingMessage(pageNo:int, pageSize:int):String {
      return JSON.stringify({"action": ActionNames.HALL_MYFOLLOW, pageNo:pageNo,pageSize:pageSize});
    }

    public static function createHotLivingMessage(pageNo:int, pageSize:int):String {
      return JSON.stringify({"action": ActionNames.HALL_HOT_LIVE, pageNo:pageNo,pageSize:pageSize});
    }
    public static function createGrabPieMessage(index:int):String {
      return JSON.stringify({"action":ActionNames.PIE_GRAB, "position":index});
    }

    public static function createBridgeProgressMessage():String{
      return JSON.stringify({"action":ActionNames.ACTIVITY_PROGRESS});;
    }
    public static function createMoonGameMessage():String {
      return JSON.stringify({"action":ActionNames.MOON_GAME});
    }
    public static function createActivityRankMessage(today:int, rankType:int):String {
      return JSON.stringify({"action":ActionNames.ACTIVITY_RANK,"today":today,"rankType":rankType});
    }
    
    public static function createEvilActivityRankMessage(today:int, rankType:int, id:int):String {
      return JSON.stringify({"action":ActionNames.ACTIVITY_RANK,"today":today,"rankType":rankType, "activityId":id});
    }

    public static function createEditManifesto(content:String):String {
      return JSON.stringify({"action":ActionNames.UPDATE_MANIFESTO, "manifesto":content});
    }

    public static function createStartFamilyRoom():String {
      return JSON.stringify({"action":ActionNames.FAMILY_ROOM_EVENT, "type":1});
    }
    public static function createStopFamilyRoom():String {
      return JSON.stringify({"action":ActionNames.FAMILY_ROOM_EVENT, "type":0});
    }
    public static function createStartMicQueue():String {
      return JSON.stringify({"action":ActionNames.MICRO_START});
    }
    public static function createPauseMicQueue():String {
      return JSON.stringify({"action":ActionNames.MICRO_PAUSE});
    }
    public static function createAgreeUpMic(isOwner:Boolean):String {
      return JSON.stringify({"action":ActionNames.MICRO_ACCEPT,"isOwner":isOwner});
    }
    public static function createRefuseUpMic():String {
      return JSON.stringify({"action":ActionNames.MICRO_REFUSE});
    }
    public static function createCancelChangeMic(familyRoomId : int):String {
      return JSON.stringify({"action":ActionNames.MICRO_CHANGE_CANCEL, "familyRoomId":familyRoomId});
    }
    public static function createChangeMic(target:String):String {
      return JSON.stringify({"action":ActionNames.MICRO_CHANGE,"targetId":target});
    }
    public static function createAssignPresenter(anchorId:String):String {
      return JSON.stringify({"action":ActionNames.ASSIGN_PRESENTER,"anchorId":anchorId});
    }
    public static function createFamilyRoomInfo():String {
      return JSON.stringify({"action":ActionNames.FAMILY_INFO});
    }
    public static function createFamilyMicroQueue():String {
      return JSON.stringify({"action":ActionNames.MICROQUEUE});
    }
    
    public static function createLivingStatus():String {
      return JSON.stringify({"action":ActionNames.VIDEO_STATUS});
    }
    
    public static function createOpenLiving():String {
      return JSON.stringify({"action":ActionNames.VIDEO_OPERATE, "type":1});
    }
    
    public static function createCloseLiving():String {
      return JSON.stringify({"action":ActionNames.VIDEO_OPERATE, "type":0});
    }

    public static function createPJoinMic():String {
      return JSON.stringify({"action":ActionNames.MICRO_JOIN});
    }
    public static function createClearMic(param:Array):String {
      return JSON.stringify({"action":ActionNames.MICRO_CLEAR,"anchorIds":param});
    }
    public static function createQuitMic():String {
      return JSON.stringify({"action":ActionNames.MICRO_EXIT});
    }
    public static function createMicroRemove(target:String):String {
      return JSON.stringify({"action":ActionNames.MICRO_REMOVE,"targetId":target});
    }

    public static function createMicroMove(targetId:String, beforeId:String):String {
      return JSON.stringify({"action":ActionNames.MICRO_MOVE,"targetId":targetId,"beforeId":beforeId});
    }
    
    public static function createSingleAnchorConsumeRank(roomEventId:int, anchor:String):String {
      return JSON.stringify({"action":ActionNames.SINGLE_ANCHOR_CONSUME_RANK, "roomEventId":roomEventId, "anchorId":anchor, "start":0, "limit":5});
    }
    
    public static function createMvRank(mvId : int):String {
      return JSON.stringify({"action":ActionNames.MV_RANK, "mvId" : mvId});
    }
    
    public static function createGeneralTopRankMessage(activityId:int, type:int,limit:int = 10):String {
      return JSON.stringify({"action":ActionNames.GENERALTOPRANK, "activityId":activityId,"rankType":type,"limit":limit});
    }
    
    public static function updateChatLevel(level : int, duration : int):String {
      return JSON.stringify({"action":ActionNames.UPDATE_CHAT_LEVEL, "chatLevel" : level, "duration" : duration});
    }
    
    public static function createSprintHaloGet(wave : int):String {
      return JSON.stringify({"action":ActionNames.SPRINT_HALO_GET, "wave": wave});
    }
    public static function createAcParticipants(ids:Array):String {
      var param:String = "";
      for each(var id:int in ids){
        param = param +id+",";
      }
      param = param.substr(0,param.length-1);
      return JSON.stringify({"action":ActionNames.GET_AC_PARTICIPANTS,"activityIds":param});
    }
    public static function createAnchorReward():String {
      return JSON.stringify({"action":ActionNames.ANCHOR_REWARD});
    }
    
    public static function createStartTimerInfo(time:Number):String {
      return JSON.stringify({"action":ActionNames.MIC_START_TIMER,"duration":time});
    }
    public static function createPauseTimerInfo():String {
      return JSON.stringify({"action":ActionNames.MIC_PAUSE_TIMER});
    }
    public static function createProceedTimerInfo():String {
      return JSON.stringify({"action":ActionNames.MIC_RESUME_TIMER});
    }
    public static function createStopTimerInfo():String {
      return JSON.stringify({"action":ActionNames.MIC_STOP_TIMER});
    }
    
    public static function createGameEggInfo():String {
      return JSON.stringify({"action":ActionNames.GAME_EGG_INFO});
    }
    
    public static function createMVInfo():String {
      return JSON.stringify({"action":ActionNames.MV_INFO});
    }
    public static function createMVStart():String {
      return JSON.stringify({"action":ActionNames.MV_START});
    }

    public static function createFavRoomMessage(favRoomId : int = 0):String {
      return JSON.stringify({"action":ActionNames.FAV_ROOM, "favRoomId":favRoomId});
    }
    public static function createUnfavRoomMessage():String {
      return JSON.stringify({"action":ActionNames.UNFAV_ROOM});
    }

    public static function createEnterFactionChat(model:Object,captchaToken:String = "",captchaCode:String = ""):String {
      if (!model) {
        return '';
      }
      
      var token:CryptoToken = new CryptoToken();
      token.gen(model.token);
      
      return JSON.stringify({"userId":model.selfModel.userId, 
                             "action":ActionNames.ROOM_ENTER,
                             "token":token.ct,
                             "timestamp":token.time,
                             "random":token.rand,
                             "fp":Fgp.get(),
                             "captchaToken":captchaToken,
                             "captchaCode":captchaCode});
    }
    
    public static function createAllAcs():String {
      return JSON.stringify({"action":ActionNames.GET_ALL_ACS});
    }
    
    public static function createStartVote():String {
      return JSON.stringify({"action":ActionNames.START_VOTE});
    }
    
    public static function createVote():String {
      return JSON.stringify({"action":ActionNames.VOTE});
    }

    public static function createPacketSend(cCurrency : int):String {
      return JSON.stringify({"action":ActionNames.PACKET_SEND, "cCurrency": cCurrency});
    }
	public static function createPacketPlusSend(cCurrency : int, strategy:int, packetNum:int):String 
	{
		return JSON.stringify({"action":ActionNames.PACKET_SEND, "cCurrency": cCurrency, "strategy":strategy, "packetNum":packetNum});
	}

	public static function createPacketPlusSendBorichmsg(packetId:String):String
	{
		return JSON.stringify({"action":ActionNames.SEND_BORICHMSG, "packetId":packetId});
	}
	
	public static function createPacketPlusGIFT(giftId : int, giftNum:int):String 
	{
		return JSON.stringify({"action":ActionNames.SEND_GIFT_PACHKET, "giftId": giftId, "giftNum":giftNum});
	}

	public static function createPacketPlusSendGiftRichMsg(packetId:String):String
	{
		return JSON.stringify({"action":ActionNames.SEND_GIFT_RICHMSG, "packetId":packetId});
	}
	
//    public static function createPacketGet(packetId : int):String {
//      var key:String = "packetOnSending#" + packetId;
//      var sign:int = Encrypt(key);
//      return JSON.stringify({"action":ActionNames.PACKET_GET, "packetId": packetId, "sign":sign});
//    }

	public static function creatPacketGetGift(packetId:int):String
	{
		return JSON.stringify({"action":ActionNames.PACKET_GET_GIFT, "packetId": packetId}); 
	}
	
    public static function createPacketThanks(userId : String):String {
      return JSON.stringify({"action": ActionNames.PACKET_THANKS, "toUserId": userId});
    }
    public static function updateWelcomeLevel(level:int):String {
      return JSON.stringify({"action":ActionNames.UPDATE_WELCOME_LEVEL,"welcomeLevel":level});
    }

    public static function updatePacketSendRank():String {
      return JSON.stringify({"action":ActionNames.UPDATE_PACKET_SEND_RANK});
    }

    public static function updatePacketGetRank():String {
      return JSON.stringify({"action":ActionNames.UPDATE_PACKET_GET_RANK});
    }

    public static function guardInfo():String {
      return JSON.stringify({"action":ActionNames.ROOM_ITEM_INFO});
    }

    public static function createRedPacketGet(wave : int):String {
      return JSON.stringify({"action":ActionNames.RED_PACKET_GET, "wave": wave});
    }

    public static function createTaskGiftConfigMessage(start:int, hour:int, reward1:String, reward2:String, giftId:int, giftNum:int):String {
      var taskInfo:Object = {
          "taskType": "0",
          "startHour":hour, //开始的整点数
          "startTimeType": start, // 0今天1明天
          "factionAdminReward":reward1,
          "factionMemberReward": reward2,
          "giftId": giftId,
          "giftNum": giftNum
      };
      return JSON.stringify({"action":ActionNames.ADD_ANCHOR_TASK_CONFIG, "taskInfo":taskInfo});
    }
    public static function createTaskSofaConfigMessage(start:int, hour:int, reward1:String, reward2:String):String {
      var taskInfo:Object = {
          "taskType": "2",
          "startHour":hour, //开始的整点数
          "startTimeType": start, // 0今天1明天
          "factionAdminReward":reward1,
          "factionMemberReward": reward2
      };
      return JSON.stringify({"action":ActionNames.ADD_ANCHOR_TASK_CONFIG, "taskInfo":taskInfo});
    }
    
    public static function createTaskTrendMessage():String {
      return JSON.stringify({"action":ActionNames.GET_TASK_TREND});
    }

    public static function createOngoingMessage():String {
      return JSON.stringify({"action":ActionNames.GET_ONGOING_TASK_LIST});
    }
    public static function createTaskAcceptableMessage():String {
      return JSON.stringify({"action":ActionNames.GET_ACCEPTABLE_TASK_LIST});
    }
    public static function createDeleteAnchorSelfTaskMessage():String {
      return JSON.stringify({"action":ActionNames.GET_ACCEPTABLE_TASK_LIST});
    }

    public static function createAcceptTaskMessage(id:int):String {
      return JSON.stringify({"action":ActionNames.ACCEPT_ANHOR_FACTION_TASK, "configId":id});
    }
    public static function createStartLuckyBo(conditions : Array, wealthLevel : int, probability : int, constraint : int):String {
      return JSON.stringify({"action":ActionNames.START_LUCKY_BO,
        "conditions": conditions, "wealthLevel": wealthLevel, probability: probability, constraint : constraint});
    }

    public static function createStopLuckyBo(recId : int):String {
      return JSON.stringify({"action":ActionNames.STOP_LUCKY_BO, "recId": recId});
    }

    public static function createChuoLuckyBo(recId : int):String {
      return JSON.stringify({"action":ActionNames.CHUO_LUCKY_BO, "recId": recId});
    }

    public static function createurrentLuckyBo():String {
      return JSON.stringify({"action":ActionNames.CURRENT_LUCKY_BO});
    }

    public static function createTaskStatus():String {
      return JSON.stringify({"action":ActionNames.GET_ANCHOR_TASK_STATUS});
    }
    public static function createRoomAnchorTaskStatus():String {
      return JSON.stringify({"action":ActionNames.GET_ROOM_ANCHOR_TASK_STATUS});
    }

    public static function createdDeleteAnchorSelfTask():String {
      return JSON.stringify({"action":ActionNames.DELETE_ANCHOR_SELF_TASK});
    }

    public static function createdRandomTask():String {
      return JSON.stringify({"action":ActionNames.GET_RANDOM_ANCHOR_TASK});
    }
    
    public static function createCompleteTask(id:int):String {
      return JSON.stringify({"action":ActionNames.FACTION_WORSHIP, "factionId": id});
    }

    public static function createChooseFree(freeGiftId : int):String {
      return JSON.stringify({"action":ActionNames.CHOOSE_FREE, "freeGiftId": freeGiftId});
    }
    
    public static function foolsDayInfo():String {
      return JSON.stringify({"action":ActionNames.FOOLS_DAY_INFO});
    }
    public static function createPopularityRank(roomEventId:int, start : int, limit : int):String {
      return JSON.stringify({"action":ActionNames.POPULARITY_RANK, "roomEventId":roomEventId, "start":start, "limit":limit});
    }

    public static function createActivityDateRank(date : String):String {
      return JSON.stringify({"action":ActionNames.ACTIVITY_DATE_RANK, "date" : date});
    }

    public static function createSignInInfo():String {
      return JSON.stringify({"action":ActionNames.SIGN_IN_INFO});
    }

    public static function createSignIn():String {
      return JSON.stringify({"action":ActionNames.SIGN_IN});
    }

    public static function createRandomLuckyDay():String {
      return JSON.stringify({"action": ActionNames.RANDOM_LUCKY_DAY});
    }

    public static function createSpecialRank(activityId:int):String {
      return JSON.stringify({"action":ActionNames.SPECIAL_RANK, "activityId":activityId});
    }

    public static function createGoldRoomStatusMessage():String {
      return JSON.stringify({"action":ActionNames.LIST_GOLD_ROOM});
    }

    public static function createGoldRoomUserRankMessage(id:int):String {
      return JSON.stringify({"action":ActionNames.GOLD_ROOM_USER_RANK, "rankType":1, "activityId":id});
    }
    public static function createGoldRoomAnchorRankMessage(id:int):String {
      return JSON.stringify({"action":ActionNames.GOLD_ROOM_ANCHOR_RANK, "rankType":1, "activityId":id});
    }

    public static function createPersonalTaskMessage():String {
      return JSON.stringify({"action":ActionNames.PERSONAL_TASK_LIST});
    }

    public static function createUserTaskRewardMessage(id:int, configId:int):String {
      return JSON.stringify({"action":ActionNames.GET_PERSONAL_TASK_REWARD, "taskId":id, "configId":configId});
    }
    public static function createListPeachBlossom():String {
      return JSON.stringify({"action":ActionNames.LIST_PEACH_BLOSSOM});
    }

    public static function createGetRedHeartProgress():String {
      return JSON.stringify({"action":ActionNames.GET_RED_HEART_PROGRESS});
    }

    public static function createActivityFirstAnchorRank(activityId : int):String {
      return JSON.stringify({"action":ActionNames.ACTIVITY_FIRST_ANCHOR_RANK,
        "activityId": activityId,
        "integralType": 2,
        "addType": 1,
        "dateType": 2
      });
    }

    public static function activityFirstUser1Rank(activityId : int):String {
      return JSON.stringify({"action":ActionNames.ACTIVITY_FIRST_USER1_RANK,
        "activityId": activityId,
        "dateType": 2
      });
    }

    public static function activityFirstUser2Rank(activityId : int):String {
      return JSON.stringify({"action":ActionNames.ACTIVITY_FIRST_USER2_RANK,
        "activityId": activityId,
        "dateType": 2
      });
    }

    public static function createActivitySecondScoreRank(activityId : int, rankType : int):String {
      return JSON.stringify({"action":ActionNames.ACTIVITY_SECOND_SCORE_RANK,
        "activityId": activityId,
        "rankType": rankType
      });
    }

    public static function createActivityThirdScoreRank(activityId : int, rankType : int):String {
      return JSON.stringify({
        "action": ActionNames.ACTIVITY_THIRD_SCORE_RANK,
        "activityId": activityId,
        "rankType": rankType
      });
    }

    public static function createListHeadlines():String {
      return JSON.stringify({"action":ActionNames.LIST_HEADLINES});
    }

    public static function createHeadlinesUserRank(activityId : int, rankType : int):String {
      return JSON.stringify({"action":ActionNames.HEADLINES_USER_RANK, "activityId" : activityId, "rankType" : rankType});
    }

    public static function createHeadlinesAnchorRank(activityId : int, round : int, rankType : int):String {
      return JSON.stringify({"action":ActionNames.HEADLINES_ANCHOR_RANK, "activityId" : activityId, "round" : round, "rankType" : rankType});
    }
    
    public static function createUserMicListMessage():String {
      return JSON.stringify({"action":ActionNames.USER_APP_LIST_INFO});
    }
    public static function createUserMicPickMessage(userId:String):String {
      return JSON.stringify({"action":ActionNames.USER_MIC_PICK, "userInfoId":userId});
    }

    public static function createUserMicRemove(userId:String):String {
      return JSON.stringify({"action":ActionNames.USER_MIC_REMOVE, "userInfoId":userId, "moveReason":3});
    }
    
//    public static function createUserMicStopOnMicUser(userId:String):String {
//      return JSON.stringify({"action":ActionNames.USER_MIC_REMOVE, "userInfoId":userId, "moveReason":4});
//    }
    
    public static function createUserMicUserCancel():String {
      return JSON.stringify({"action":ActionNames.USER_MIC_REMOVE, "moveReason":1});
    }

    public static function createUserMicPause(userId:String):String {
      return JSON.stringify({"action":ActionNames.USER_MIC_START_OR_PAUSE, "userInfoId":userId, "type":0});
    }
    
    public static function createUserMicStart(userId:String):String {
      return JSON.stringify({"action":ActionNames.USER_MIC_START_OR_PAUSE, "userInfoId":userId, "type":1});
    }
    
    public static function createUserMicClearQueue():String {
      return JSON.stringify({"action":ActionNames.USER_MIC_CLEAR_QUEUE});
    }
    
    public static function createUserMicJoinQueue():String {
      return JSON.stringify({"action":ActionNames.USER_MIC_APP_MIC});
    }
    public static function createLastWinFactionMessage():String {
      return JSON.stringify({"action":ActionNames.LAST_WIN_FACTION_IN_ROOM});
    }
    public static function createIfApply():String {
      return JSON.stringify({"action":ActionNames.IF_APPLY});
    }

    public static function createGetCurrentWeekRank(giftId : int):String {
      return JSON.stringify({"action":ActionNames.GET_CURRENT_WEEK_RANK, "giftId" : giftId});
    }

    public static function createGetPreviousWeekFistRank(giftId : int):String {
      return JSON.stringify({"action":ActionNames.GET_PREVIOUS_WEEK_FIST_RANK, "giftId" : giftId});
    }

    public static function createGetCurrentGiftRank(giftId : int):String {
      return JSON.stringify({"action":ActionNames.GET_CURRENT_GIFT_RANK, "giftId" : giftId});
    }
    public static function createZongziInfo():String {
      return JSON.stringify({"action":ActionNames.GET_ZHUZONGZI_INFO});
    }

    public static function createDuanwuPacket():String {
      return JSON.stringify({"action":ActionNames.GET_DUANWU_PACKET});
    }
    
    public static function createSpeedInfoMessage():String {
      return JSON.stringify({"action":ActionNames.GET_SPEED_INFO});
    }
    
    public static function createSpeedRank(type:int, limit : int):String {
      return JSON.stringify({"action":ActionNames.GET_SPEED_RANK, "limit": limit, "rankType":type});
    }
    
    public static function getSweetSaltyInfo():String {
      return JSON.stringify({"action":ActionNames.GET_SWEET_SALTY_INFO});
    }
    
    public static function getBuildBoatInfo():String {
      return JSON.stringify({"action":ActionNames.GET_BUILD_BOAT_INFO});
    }
    public static function getDwFamilyRank():String {
      return JSON.stringify({"action":ActionNames.GET_DW_FAMILY_RANK});
    }

    public static function getDwFamilyFinalRank():String {
      return JSON.stringify({"action":ActionNames.GET_DW_FAMILY_FINAL_RANK});
    }

    public static function getTianXianRank(type:int):String {
      return JSON.stringify({"action":ActionNames.GET_TIAN_XIAN_RANK,"rankType":type,"limit":5});
    }
    public static function getTianXianInfo():String {
      return JSON.stringify({"action":ActionNames.GET_TIAN_XIAN_INFO});
    }

    public static function createSchoolGoodVoiceYXRank(type : int):String {
      return JSON.stringify({"action":ActionNames.SCHOOL_GOOD_VOICE_YX_RANK, "type" : type});
    }
    
    public static function createUpdateRoomType(type:int):String {
      return JSON.stringify({"action":ActionNames.UPDATE_ROOM_TYPE, "themeType":type});
    }
    public static function createUpdateWidget(nick : String, imageType : int):String {
      return JSON.stringify({"action":ActionNames.UPDATE_WIDGET, "nick" : nick, "imageType" : imageType});
    }

    public static function createWidgetInfoConfig():String {
      return JSON.stringify({"action":ActionNames.WIDGET_INFO_CONFIG});
    }

    public static function createSelectPersonalMsgs():String {
      return JSON.stringify({"action":ActionNames.SELECT_PERSONAL_MSGS});
    }

    public static function createSelectOfficialMsgs():String {
      return JSON.stringify({"action":ActionNames.SELECT_OFFICIAL_MSGS});
    }

    public static function createGetRandomAnchors():String {
      return JSON.stringify({"action":ActionNames.GET_RANDOM_ANCHORS});
    }

    public static function createGetRandomOneAnchor():String {
      return JSON.stringify({"action":ActionNames.GET_RANDOM_ONE_ANCHOR});
    }

    public static function createSelectActivityMsgs():String {
      return JSON.stringify({"action":ActionNames.SELECT_ACTIVITY_MSGS});
    }

    public static function createFinishGuide():String {
      return JSON.stringify({"action":ActionNames.FINISH_GUIDE});
    }

    public static function createPreviewChangeMesage(type:int):String {
      return JSON.stringify({"action":ActionNames.BOBO_CONN_WINDOW_CHANGE, "window":type});
    }    
    public static function createPushURL():String {
      return JSON.stringify({"action":ActionNames.GET_ANCHOR_PUSH_CDN});
    }
    public static function qixiActivityAnchorInfo():String {
      return JSON.stringify({"action":ActionNames.QIXI_AC_ANCHOR_INFO});
    }
    public static function qixiActivityRankInfo(type:int, dateType:int):String {
      return JSON.stringify({"action": ActionNames.QIXI_AC_RANK_INFO, "rankType": type, "dataType": dateType});
    }
    public static function takeMicroActivityBoBoToday():String {
      return JSON.stringify({"action":ActionNames.MICRO_ACTIVITY_ANCHOR});
    }
    public static function takeMicroActivityUserToday():String {
      return JSON.stringify({"action":ActionNames.MICRO_ACTIVITY_USER});
    }
    public static function getUserScore():String {
      return JSON.stringify({"action":ActionNames.GET_USER_SCORE});
    }
  }
}
