//
//  AgendaController.swift
//  Agenda1
//
//  Created by Felipe Neves Brito on 4/5/16.
//  Copyright © 2016 Felipe Neves Brito. All rights reserved.
//

class AgendaController{

    var agenda:Agenda = Agenda()
    let dataLoader:AgendaDataLoader = AgendaDataLoader()
    
    init(){
        self.agenda = self.dataLoader.getAgenda()
    }
    
    func getAgenda() -> Agenda{
        return self.agenda
    }
    
    func getEventAt(index:Int) ->Event{
        return self.agenda.events[index]
    }
    
    func getEventsCount() -> Int{
        return agenda.events.count
    }
}
