/*
    Plugin-SDK (Grand Theft Auto) header file
    Authors: GTA Community. See more here
    https://github.com/DK22Pac/plugin-sdk
    Do not delete this comment block. Respect others' work!
*/
#pragma once

#include "plbase/PluginBase_SA.h"
#include "CTaskComplexSmartFleeEntity.h"

class PLUGIN_API CTaskComplexFleeAnyMeans : public CTaskComplexSmartFleeEntity {
protected:
    CTaskComplexFleeAnyMeans(plugin::dummy_func_t a) : CTaskComplexSmartFleeEntity(a) {}
public:
    
};

//VALIDATE_SIZE(CTaskComplexFleeAnyMeans, 0x);