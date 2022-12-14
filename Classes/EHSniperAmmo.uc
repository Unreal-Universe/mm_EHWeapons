class EHSniperAmmo extends Ammunition;

#EXEC OBJ LOAD FILE=InterfaceContent.utx

defaultproperties
{
     MaxAmmo=35
     InitialAmount=15
     bTryHeadShot=True
     PickupClass=Class'EHWeaponsE.EHSniperAmmoPickup'
     IconMaterial=Texture'HUDContent.Generic.HUD'
     IconCoords=(X1=451,Y1=445,X2=510,Y2=500)
     ItemName="Enhanced Sniper Bullets"
}
