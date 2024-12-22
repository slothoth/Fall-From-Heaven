include('TechTree_Expansion2');

local SIZE_ART_ERA_OFFSET_X	    = 40;				-- these other variables are needed for the function
local SIZE_ART_ERA_START_X      = 40;
local PARALLAX_SPEED            = 1.1;
local PARALLAX_ART_SPEED        = 1.2;
local SIZE_WIDESCREEN_HEIGHT    = 768;
local SIZE_TIMELINE_AREA_Y	    = 341;              -- changed to +300
ROW_MAX					= 7;													-- changed to +3

function Resize()
	m_width, m_height	= UIManager:GetScreenSizeVal();		-- Cache screen dimensions
	m_scrollWidth		= m_width - 80;						-- Scrollbar area (where markers are placed) slightly smaller than screen width

	-- Determine how far art will span.
	-- First obtain the size of the tree by taking the visible size and multiplying it by the ratio of the full content
	local scrollPanelX = (Controls.NodeScroller:GetSizeX() / Controls.NodeScroller:GetRatio());

	local artAndEraScrollWidth = math.max( scrollPanelX * (1/PARALLAX_SPEED), m_width )
		+ SIZE_ART_ERA_OFFSET_X
		+ SIZE_ART_ERA_START_X;

	Controls.ArtParchmentDecoTop:SetSizeX( artAndEraScrollWidth );
	Controls.ArtParchmentDecoBottom:SetSizeX( artAndEraScrollWidth );
	Controls.ArtParchmentRippleTop:SetSizeX( artAndEraScrollWidth );
	Controls.ArtParchmentRippleBottom:SetSizeX( artAndEraScrollWidth );
	Controls.ForceSizeX:SetSizeX( artAndEraScrollWidth );
	Controls.ForceArtSizeX:SetSizeX( scrollPanelX * (1/PARALLAX_ART_SPEED) );
	Controls.LineForceSizeX:SetSizeX( scrollPanelX );
	Controls.LineScroller:CalculateSize();
	Controls.ArtScroller:CalculateSize();

	local backArtScrollWidth = scrollPanelX * (1/PARALLAX_ART_SPEED) + 100;
	Controls.Background:SetSizeX( math.max(backArtScrollWidth, m_width) );
	Controls.Background:SetSizeY( SIZE_WIDESCREEN_HEIGHT - (SIZE_TIMELINE_AREA_Y - 8) + 300 );
	Controls.EraArtScroller:CalculateSize();
end

include('TechTree_support.lua')