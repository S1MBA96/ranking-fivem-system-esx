$("html").hide();
function gracze() {
	$("#gracze").css("display","");
	$("#org").css("display","none");
	$("#kile").css("display","none")
	$("#faktury").css("display","none")
	$("#ranking").css("display","none")
	$("#napady").css("display","none")

}

function org() {
	$("#gracze").css("display","none");
	$("#org").css("display","");
	$("#kile").css("display","none")
	$("#faktury").css("display","none")
	$("#ranking").css("display","none")
	$("#napady").css("display","none")

}

function kile() {
	$("#gracze").css("display","none");
	$("#org").css("display","none");
	$("#kile").css("display","")
	$("#faktury").css("display","none")
	$("#ranking").css("display","none")
	$("#napady").css("display","none")

}

function faktury() {
	$("#gracze").css("display","none");
	$("#org").css("display","none");
	$("#kile").css("display","none")
	$("#faktury").css("display","")
	$("#ranking").css("display","none")
	$("#napady").css("display","none")

}

function ranking() {
	$("#gracze").css("display","none");
	$("#org").css("display","none");
	$("#kile").css("display","none")
	$("#faktury").css("display","none")
	$("#ranking").css("display","")
	$("#napady").css("display","none")

}

function napady() {
	$("#gracze").css("display","none");
	$("#org").css("display","none");
	$("#kile").css("display","none")
	$("#faktury").css("display","none")
	$("#ranking").css("display","none")
	$("#napady").css("display","")

}



$(function () {
	window.addEventListener("message",
	
	  function (a) {
		switch (a.data.action) {



		case "data":
		  (e = a.data.ServerName) && "" != e && $(".logo").attr("src", e),
			function (a) {
				console.log(JSON.stringify(a))
			for ($(".count.active").text(a.playerCount), $("#list_gracze, #list_org, .ing_rank").html(""), i = 0; i < a.playtime.length; i++)
			
			$("#list_gracze").append(
				`
					<div class="ranking_item">
						<div class="ranking_inside_position">${i+1}</div>
						<div class="ranking_inside_name">${a.playtime[i].name}</div>
						<div class="ranking_inside_points">${a.playtime[i].id} Godzin.</div>
					</div>
				`);

			  for (i = 0; i < a.jobs.length; i++) a.jobs[i].count >= 1 && $("#list_org").append(`

					<div class="ranking_item">
						<div class="ranking_inside_position">${i+1}</div>
						<div class="ranking_inside_name">${a.jobs[i].label}</div>
						<div class="ranking_inside_points">${a.jobs[i].count} pkt.</div>
					</div>
				`);

				for ($("#list_kile").html(""), i = 0; i < a.playerKile.length; i++)
				$("#list_kile").append(
					`
					<div class="ranking_item">
						<div class="ranking_inside_position">${i+1}</div>
						<div class="ranking_inside_name">${a.playerKile[i].name}</div>
						<div class="ranking_inside_points">${a.playerKile[i].kile} pkt.</div>
					</div>
					`);

					for ($("#list_napady").html(""), i = 0; i < a.playerNapady.length; i++)
					$("#list_napady").append(
						`
						<div class="ranking_item">
							<div class="ranking_inside_position">${i+1}</div>
							<div class="ranking_inside_name">${a.playerNapady[i].name}</div>
							<div class="ranking_inside_points">${a.playerNapady[i].napady} pkt.</div>
						</div>
						`);

							for ($("#list_faktury").html(""), i = 0; i < a.playerFaktury.length; i++)
							$("#list_faktury").append(
								`
								<div class="ranking_item">
									<div class="ranking_inside_position">${i+1}</div>
									<div class="ranking_inside_name">${a.playerFaktury[i].name}</div>
									<div class="ranking_inside_points">${a.playerFaktury[i].faktury} pkt.</div>
								</div>
								`);

								for ($("#list_ranking").html(""), i = 0; i < a.playerRanking.length; i++)
								$("#list_ranking").append(
									`
									<div class="ranking_item">
										<div class="ranking_inside_position">${i+1}</div>
										<div class="ranking_inside_name">${a.playerRanking[i].name}</div>
										<div class="ranking_inside_points">${a.playerRanking[i].uranking} pkt.</div>
									</div>
									`);


								

			}(a.data.data);
		  break;
		case "showPanel":
		  a.data.status ? $("html").fadeIn(200) : $("html").fadeOut(200) 
		}
		
		var e

	  }),

	$(document).keyup(function (a) {
	  "Escape" === a.key && ($("game").fadeOut(200), $.post("https://foxrp_ranking/close", JSON.stringify({})))
	})

  });


  