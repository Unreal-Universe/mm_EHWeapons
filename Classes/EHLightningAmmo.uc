class EHLightningAmmo extends Ammunition;

#EXEC OBJ LOAD FILE=InterfaceContent.utx

defaultproperties
{
     MaxAmmo=40
     InitialAmount=15
     bTryHeadShot=True
     PickupClass=Class'EHWeaponsE.EHLightningAmmoPickup'
     IconMaterial=Texture'HUDContent.Generic.HUD'
     IconCoords=(X1=458,Y1=82,X2=491,Y2=133)
     ItemName="Enhanced Lightning Charges"
}
