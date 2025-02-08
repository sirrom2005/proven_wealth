class MyAppState
{
  bool _showLargePlayer = true;

  showLargePlayer(){
    return _showLargePlayer;
  }

  canShowLargePlayer(bool s){
    _showLargePlayer = s;
  }
}