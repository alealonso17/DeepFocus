//
//  ContentView.swift
//  DeepFocus
//
//  Created by Alejandro Alonso on 29/12/25.
//

import SwiftUI
import SwiftData

struct TaskView: View {
    @State var input = ""
    @Environment(\.modelContext) var modelContext
    @Query(filter: #Predicate<TaskModel> { $0.isCompleted }) var completedTasks: [TaskModel]
    @Query(filter: #Predicate<TaskModel> { !$0.isCompleted }) var uncompletedTasks: [TaskModel]
    @FocusState var isFocused:Bool
    var inputText:String{
        isFocused ? "What do you want to acomplish?" : "Add a new task"
    }
    var body: some View {
        VStack {
            HeaderView(title: "DeepWork", description: "No tasks yet")
            VStack{
                ZStack(alignment: .leading){
                    Rectangle().cornerRadius(16).frame(maxWidth: .infinity, maxHeight: 60).padding(.horizontal, 20).foregroundColor(.white)
                    if input.isEmpty{
                        HStack(spacing: 8) {
                            if !isFocused{
                                ZStack{
                                    Image(systemName: "plus")
                                        .foregroundColor(.blue)
                                        .padding(.horizontal, 30)
                                    Circle().frame(width: 26, height: 26).foregroundColor(.blue.opacity(0.2))
                                }
                                
                            }
                            Text(inputText)
                                .foregroundColor(.gray)
                                .offset(x: isFocused ? 25 : -20)
                            
                        }.padding(.horizontal, 10 )
                    }
                    TextField("", text: $input)
                        .padding()
                        .padding(.horizontal, 20)
                        .focused($isFocused)
                        .onSubmit{
                            if input.isEmpty{return}
                            saveData(title: input)
                            input=""
                            isFocused=false
                        }
                }
            }.frame(maxWidth: .infinity,maxHeight: 100).background(Color.backgroundTask)
            
            if( !uncompletedTasks.isEmpty || !completedTasks.isEmpty){
                List{
                    Section(header: Text("Completed Tasks (\(completedTasks.count))")){
                        ForEach(completedTasks){task in
                            TaskContainer(task: task)
                        }
                    }
                    Section(header: Text("Pending Tasks (\(uncompletedTasks.count))")){
                        ForEach(uncompletedTasks){task in
                            TaskContainer(task: task)
                        }
                    }
                }.listStyle(.sidebar).scrollContentBackground(.hidden)
            }else{
                Spacer()
            }
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        func saveData(title:String){
            let task = TaskModel(title: title)
            modelContext.insert(task)
        }
    }
    
    
    
    struct TaskContainer: View {
        @Environment(\.modelContext) private var modelContext
        var task:TaskModel
        var color:Color = Color.gray
        var body: some View {
            
            ZStack{
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 80)
                    .cornerRadius(10)
                    .foregroundColor(.backgroundTask)
                    .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(task.isCompleted ? .backgroundTask : color , lineWidth: 1.5)
                    }
                
                
                HStack{
                    HStack{
                        Button{
                            withAnimation(.spring(response: 0.25, dampingFraction: 0.7)) {
                                task.isCompleted.toggle()
                                
                            }
                        }label:{
                            Circle()
                                .stroke(Color.blue,lineWidth: 3)
                                .background(
                                    Circle()
                                        .fill(task.isCompleted ? Color.blue.opacity(0.2) : Color.clear)
                                )
                                .frame(width: 28, height: 28)
                        }
                        .overlay {
                            if task.isCompleted {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.blue)
                                    .transition(.scale)
                            }
                            
                        }
                        .buttonStyle(.plain)
                        .contentShape(Circle())
                    }
                    Text(task.title)
                        .foregroundColor(task.isCompleted ? .gray : .black)
                        .strikethrough(task.isCompleted ? true : false, color: .gray)
                    
                    Spacer()
                    VStack{
                        Text(task.createdAt.formatted(date: .abbreviated, time: .omitted))
                            .font(.system(size: 10))
                        Spacer()
                        Button{
                            withAnimation{
                                modelContext.delete(task)
                            }
                            
                        }label:{
                            Image(systemName: "trash")
                                .foregroundColor(.gray)
                                .bold()
                        }
                        .buttonStyle(.plain)
                        
                        
                    }.frame(height: 50)
                    
                    
                }
                .padding(20)
                
            }.padding(.horizontal, 20)
            
        }
        
        
    }
    
    
    #Preview {
        TaskView().modelContainer(for: TaskModel.self)
        //TaskContainer(task:TaskModel(title: "Comprar el pan"))
    }
