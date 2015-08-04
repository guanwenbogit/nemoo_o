package {
import starling.display.Sprite;

import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;

import game.MainGame;

import starling.core.Starling;

public class Main extends Sprite {
    private var starling:Starling;

    public function Main() {
        this.addEventListener(Event.ADDED_TO_STAGE, onAdded)
    }

    private function onAdded(event:Event):void {
        starling = new Starling(MainGame, this.stage);
        starling.start();
    }
}
}

