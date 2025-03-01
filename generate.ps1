param(
    $server = "localhost:5500"
)
$Data = gc -raw ./tracker.json | convertfrom-json

$images =       $($data | %{
    "<a href=`"$($_.image)`" data-ngthumb=`"$($_.image)`" data-ngdesc=`"$($_.name)`">$($_.id)</a>"
  })

$htmlTemplate = @"
<html>
  <head>
    <meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1, maximum-scale=1">

    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/jquery@3.3.1/dist/jquery.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/nanogallery2@3/dist/css/nanogallery2.min.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/nanogallery2@3/dist/jquery.nanogallery2.min.js"></script>

  </head>
  <body>

    <h1>OnyxTrackerV2</h1>
    <h2>Gallery made with nanogallery2</h2>

    <div ID="ngy2p" data-nanogallery2='{
        "itemsBaseURL": "http://$server/",
        "thumbnailWidth": "200",
        "thumbnailLabel": {
          "position": "overImageOnBottom"
        },
        "thumbnailAlignment": "center",
        "thumbnailOpenImage": true
      }'>

      $images

    </div>
    <p>
        Come join the discussion on reddit: <a href="https://www.reddit.com/r/Currencytradingcards/">r/Currencytradingcards</a>
    </p>
    <p>
        Website based on the original implementation by: <a href="https://www.reddit.com/user/minajacky/">u/minajacky</a>
    </p>
  </body>
</html>
"@

set-content ./bitbindernet.github.io/index.html -value $htmlTemplate -force
copy-item -Recurse ./images ./bitbindernet.github.io -force

set-content ./OnyxTrackerRedux.github.io/index.html -value $htmlTemplate -force
copy-item -Recurse ./images ./OnyxTrackerRedux.github.io -force