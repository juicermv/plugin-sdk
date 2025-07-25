/*
    Plugin-SDK (Grand Theft Auto IV) header file
    Authors: GTA Community. See more here
    https://github.com/DK22Pac/plugin-sdk
    Do not delete this comment block. Respect others' work!
*/
#pragma once
#include "PluginBase.h"
#include "CTaskComplex.h"

class CPed;

class CTaskComplexCombat : public CTaskComplex {
public:
    CTaskComplexCombat(CPed* target, int32_t unk);
};
