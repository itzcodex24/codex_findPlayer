$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
            $("#police-cap").show();
        } else {
            $("#container").hide();
            $("#police-cap").hide();
        }
    }

    display(false);

    function emptyFields() {
        $("#user-fullname").text("Unknown");
        $("#user-age").text("Unknown");
        $("#vehicles-number").text("Unknown");
        $("#track-button").css("opacity", ".6");
        $("#avatar").attr("src", "avatar.jpg");
    }

    window.addEventListener("message", function (event) {
        window.id = event.data.id;
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true);
            } else {
                display(false);
            }
            if (item.action == "updatePlayerInfo") {
                let sound = new Audio("beep.mp3");
                sound.volume = 0.8;
                sound.play();
                $("#user-fullname").text(item.firstname + " " + item.lastname);
                $("#user-age").text(item.age);
                $("#vehicles-number").text(item.masini);
                $("#track-button").css("opacity", "1");
                const pictureURL = `https://nui-img/${event.data.texture}/${event.data.texture}`;
                $("#avatar").attr("src", pictureURL);
            }
        }
    });

    $("#track-button").click(function () {
        if ($("#track-button").css("opacity") == "1") {
            $.post(
                "http://codex_findplayer/track",
                JSON.stringify({
                    target: window.id,
                })
            );
        } else {
            $.post("http://codex_findplayer/errordetails");
            $.post("http://codex_findplayer/exit", JSON.stringify({}));
        }
    });

    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post("http://codex_findplayer/exit", JSON.stringify({}));
            emptyFields();
            return;
        }
    };
    $("#get-info").click(function () {
        let licencePlateValue = $("#licencePlate").val();

        if (licencePlateValue) {
            $.post(
                "http://codex_findplayer/getInfo",
                JSON.stringify({
                    lincensePlate: licencePlateValue,
                })
            );
        } else {
            $.post("http://codex_findplayer/errordetails");
            $.post("http://codex_findplayer/exit", JSON.stringify({}));
        }
    });
});
