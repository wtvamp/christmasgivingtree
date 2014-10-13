<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChristmasGivingTree.aspx.cs" Inherits="ChristmasGivingTree.ChristmasGivingTree" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title></title>
        
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js" type="text/javascript"></script>
    <script src="Scripts/zoomer.jquery.js" type="text/javascript"></script>
    <script src="Scripts/jquery.spritely-0.3b.js" type="text/javascript"></script>


    <script type="text/javascript">
        $(document).ready(function () {
            var panning;

            $("#wrap").anythingZoomer({

                expansionSize: 70,      // How far outside the wrap edges the mouse can go
                speedMultiplier: 1.4,   // How much faster in the inside area moves than the mouse

                smallArea: "#small",    // Overrides small area ID
                largeArea: "#large",    // Overrides large area ID
                zoomPort: "#overlay",   // Overrides zoom overlay area ID
                mover: "#mover"         // Overrides mover ID

            });


            $('div[id^="ornament"]').click(function () {
                var splitID = $(this).attr('id');
                splitID = splitID.split("ornament");
                $("#gender").html($(this).children("#giftGender" + splitID[1]).html());
                $("#age").html($(this).children("#giftAge" + splitID[1]).html());
                $("#hiddenChildID").val(splitID[1]);
                $("#firstKid").show();
                $('#firstKid').sprite({ fps: 10, no_of_frames: 10, play_frames: 3 });

                setTimeout("$('#giftInfo').fadeIn();$('#giveButton').fadeIn();$('#cancelGiveButton').fadeIn();", 1000);

                $('#wrap').unbind();
                $('#mover').hide();
            });

            $('div[id^="ornament"]').hover(function () {
                var splitID = $(this).attr('id');
                splitID = splitID.split("ornament");
                $('#ornamentimage' + splitID[1]).sprite({ fps: 10, no_of_frames: 11 });
                $('#ornamentimage' + splitID[1]).spStart();
            },
            function () {
                var splitID = $(this).attr('id');
                splitID = splitID.split("ornament");
                $('#ornamentimage' + splitID[1]).spStop();
            });


            $('#hiddenelf').click(function () {
                $('#hiddenelf').sprite({ fps: 10, no_of_frames: 25, play_frames: 25 });
            });



            $('#giveButton').click(function () {
                $('#givingForm').fadeIn();
                $('#wrap').unbind();
            });


            $('#cancelGiveButton').click(function () {

                $('#giftInfo').fadeOut(); $('#giveButton').fadeOut(); $('#cancelGiveButton').fadeOut();
                setTimeout("$('#firstKid').sprite({ fps: 10, no_of_frames: 10, play_frames: 4 });", 1000);
                setTimeout("$('#firstKid').fadeOut();", 2000);
                $("#wrap").anythingZoomer({

                    expansionSize: 40,      // How far outside the wrap edges the mouse can go
                    speedMultiplier: 1.4,   // How much faster in the inside area moves than the mouse

                    smallArea: "#small",    // Overrides small area ID
                    largeArea: "#large",    // Overrides large area ID
                    zoomPort: "#overlay",   // Overrides zoom overlay area ID
                    mover: "#mover"         // Overrides mover ID

                });
            });


            $('#cancelGift').live('click', function () {
                $('#givingForm').fadeOut();
            });

            $('#hiddensnow').click(function () {
                if (panning == true) {
                    $('#snowback').spStop(true);
                    panning = false;
                }
                else if (panning == false) {
                    $('#snowback').spStart(true);
                    panning = true;
                }
                else {
                    $('#snowback').pan({ fps: 30, speed: 2, dir: 'left' });
                    panning = true;
                }
            });

            $('#makesantadance').click(function () {
                $('#dancingsanta').fadeIn(function () {
                    $('#dancingsanta').sprite({ fps: 11, no_of_frames: 11, play_frames: 55 });
                    setTimeout("$('#dancingsanta').fadeOut();", 5000);
                });
            });


        });

    </script>

    <style type="text/css">
        #wrap          { width:780px !important;height: 620px !important; position:relative; }
        #small         { position: relative; width: 100%; z-index:200;}
        #large         { background: white; position: relative; width: 900px; }
        #mover         { position: absolute; top: 0; left: 0; width: 304px; height: 304px; overflow: hidden; z-index: 300; background: white; display: none; }
        #overlay       { border: 1px solid blue; width: 300px; height: 300px; position: absolute; top: 0; left: 0; z-index: 400; }
        #smalltreecontainer { position:relative;top:-620px;left:0px; }
    </style>
    <!--[if IE]>
	<style type="text/css">      
        #small         { position: relative; width: 100%; z-index:200; top:-620px;}
        #large         { background: white; position: relative; width: 900px; z-index:400; }   
        #smalltreecontainer { position:relative;top:0px;left:0px; }             
    </style>
    <![endif]-->

</head>

<body>
    <form id="form1" runat="server" style="width:700px;margin-top:100px;margin-left:100px;">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
        
        <div id="wrap" style="float:left;background-image:url('images/christmasback_small.png')">
            <div id="snowback" style="z-index:100;width:780px;position:relative;top:-28px;height:620px;float:left;background-image:url('images/snow.png')"></div>
            <div id="test">
                <div id="small">
                    <div id="smalltreecontainer" runat="server">
                        <img src="images/small_tree.png" alt="small tree" />
                        <img src="images/smallstar.gif" alt="small star" 
                            style="position:relative;left:-281px; top:-513px; height:52px; width: 64px" />
                    </div>
                </div>

                <div id="mover">
                    <div id="overlay"></div>

                    <div id="large">
                        <div id="treecontainer" runat="server" style="position:relative;top:0px;left:0px;width:1462px;height:1169px;background-image:url('images/christmasback_large.png')">
                            <img src="images/tree.png" style="width:900px;" alt="large tree" />
                            <div id="hiddenelf" style="position:absolute;top:239px;z-index:500;left:350px;height:51px;width:32px;background-image:url('images/elf_peeking.png')"></div>
                            <div id="hiddensnow" style="position:absolute;top:40px;z-index:500;left:510px;height:70px;width:70px;background-image:url('images/transparent.png')"></div>
                            <img src="images/smallstar.gif" alt="large star" 
                            style="position:absolute;left:380px; bottom:1023px; height:100px; width: 120px" />
                            <div id="dancingsanta" style="display:none;position:absolute;top:900px;width:128px;height:150px;left:300px;z-index:500;background-image:url('images/dancingsanta.png')"></div>
                            <div id="makesantadance" style="position:absolute;top:960px;z-index:500;left:440px;height:70px;width:70px;background-image:url('images/transparent.png')"></div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
            

        <div id="firstKid" style="z-index:200;position:absolute;top:130px;left:550px;float:right;width:292px;height:253px;display:none;background-image:url('images/gift_scroll.png')">
            <div id="giftInfo" style="width:178px;padding-top:70px;padding-left:55px;display:none;">
                Would you like to give a gift to this&nbsp;<span id="age"></span>&nbsp;year old&nbsp;<span id="gender"></span>&nbsp;this holiday season?
            </div>
            <div style="margin-top:25px;">
            <span id="giveButton" style="height:15px;width:70px;margin-left:55px;padding:3px;border:#ae8444 3px groove; background-color:#744628; font-family:Georgia; color: #ceac7b; font-size: 0.8em; cursor:pointer;display:none;">Give a Gift!</span>
            <span id="cancelGiveButton" style="height:15px;width:50px;margin-left:15px;padding:3px;border:#ae8444 3px groove; background-color:#744628; font-family:Georgia; color: #ceac7b; font-size: 0.8em; cursor:pointer;display:none;">Cancel</span>
            </div>
        </div>

        <asp:UpdatePanel ID="givingForm" runat="server" style="position:absolute;top:182px;left:165px;z-index:500;display:none;padding:15px;width:320px;height:250px;background-image:url('images/santa.png');">
            <ContentTemplate>
                    <asp:Panel ID="givingFormContent" runat="server">
                        To give a gift to this child, please enter your information below:<br /><br />
                        First Name: <asp:TextBox ID="firstName" runat="server"></asp:TextBox><br />
                        Last Name: <asp:TextBox style="margin-left:1px;" ID="lastName" runat="server"></asp:TextBox><br />
                        Work Phone: <asp:TextBox style="width:139px;" ID="workPhone" runat="server"></asp:TextBox><br />
                        Home Phone: <asp:TextBox style="width:138px;" ID="homePhone" runat="server"></asp:TextBox><br />
                        Email: <asp:TextBox style="margin-left:35px;" ID="email" runat="server"></asp:TextBox><br /><br />
                        <asp:HiddenField ID="hiddenChildID" runat="server" />
                        <div style="margin-left:10px;">
                            <asp:Button ID="submitGift" runat="server" Text="Submit" onclick="submitGift_Click" />
                            <asp:Button ID="cancelGift" runat="server" Text="Cancel" />
                        </div>
                    </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>

    </form>
</body>
</html>
