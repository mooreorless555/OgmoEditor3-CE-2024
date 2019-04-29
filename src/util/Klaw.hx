package util;

import js.Error;
import js.node.fs.Stats;
import js.node.stream.Readable;

typedef Item = 
{
  path:String,
  stats:Stats
}

@:enum
abstract QueueMethod (String) from String to String
{
  var SHIFT = 'shift';
  var POP = 'pop';
}

typedef WalkerOptions =
{
  >ReadableNewOptions,
  ?queueMethod: QueueMethod,
  ?pathSorter: String->String->Int,
  ?fs: Dynamic,
  ?filter: String->Bool,
  ?depthLimit: Int,
  ?preserveSymlinks: Bool
}

// TODO - ran tests and decided not to use. Separate out into its own haxelib lib? - austin
@:jsRequire("klaw")
extern class Walker extends Readable<Walker>
{
  public function new(root:String, ?options:WalkerOptions):Void;

	@:overload(function(event:String, listener:Item->Void):Walker {})
  @:overload(function(event:String, error:Error->Void):Walker {})
  public function on(event:String, listener:Void->Void):Walker;

  public function read():Item;

  public function destroy(?error:Error):Void;
}