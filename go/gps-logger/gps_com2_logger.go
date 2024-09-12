package main

import (
	"fmt"
	"go.bug.st/serial"
	"log"
	"time"
)

func selectPort() string {
	for {
		ports, err := serial.GetPortsList()
		if err != nil {
			log.Print(err)
		}
		if len(ports) == 0 {
			log.Print("No serial ports found!")
			time.Sleep(5 * time.Second)
			continue
		}

		for i, port := range ports {
			fmt.Printf("Found port [%d]: %v\n", i, port)
		}

		var port_id int
		n, err := fmt.Scan(&port_id)
		if err != nil {
			log.Fatal(err)
		}
		if n != 1 {
			fmt.Print("Please enter a single port id")
			continue
		}
		fmt.Printf("Selected port [%d]: %v\n", port_id, ports[port_id])
		return ports[port_id]
	}
}

func read_serial(ser *serial.Port) bool {
	buff := make([]byte, 100)
	n, err := (*ser).Read(buff)
	if err != nil {
		log.Fatal(err)
		return false
	}
	if n == 0 {
		log.Print("Read Nothing")
		return false
	}
	fmt.Printf("%v", string(buff[:n]))
	return true
}

func write_serial(ser *serial.Port, input string) bool {
	// _, err := ser.Write([]byte("print('Hello')\r\n"))
	_, err := (*ser).Write([]byte(input + "\r\n"))
	if err != nil {
		log.Fatal(err)
		return false
	}
	return true
}

type SerialKey int

const (
	READ SerialKey = iota
	WRITE
)

type SerialAction struct {
	key   SerialKey
	input string
}

func handle_serial(ser *serial.Port, ch chan SerialAction) {
	for action := range ch {
            fmt.Println("Waiting for action")
		switch {
		case action.key == READ:
			read_serial(ser)

		case action.key == WRITE:
			write_serial(ser, action.input)

		default:
			fmt.Println("Invalid!")

		}
	}
}

func read_input(ch chan string) bool {
	for {
		var input string
		n, err := fmt.Scanln(&input)
		if err != nil {
			log.Print(err)
		}
		if n == 0 {
			time.Sleep(1 * time.Second)
		}
		fmt.Printf("%v", input)
		ch <- input + "\r\n"
                time.Sleep(5 * time.Second)
	}
}

const BAUDRATE = 115200

func main() {
	fmt.Println("Hello, serial devices!")
	// port := selectPort()
	// mode := &serial.Mode{
	// 	BaudRate: BAUDRATE,
	// }
	// ser, err := serial.Open(port, mode)
	// if err != nil {
	// 	log.Fatal(err)
	// }

        port := selectPort()
	mode := &serial.Mode{
		BaudRate: BAUDRATE,
	}
	ser, err := serial.Open(port, mode)
	if err != nil {
		log.Fatal(err)
	}

        var serial chan SerialAction = make(chan SerialAction)
	var input chan string = make(chan string)

	go handle_serial(&ser, serial)
	go read_input(input)

	for {
		serial <- SerialAction{READ, ""}
		select {
		case x, ok := <-input:
			if ok {
				serial <- SerialAction{WRITE, x}
			} else {
				fmt.Print("Channel Closed")
			}
		default:
		}
		// var input string
		// if read_input(&input) {
		// 	ch <- SerialAction{WRITE, &input}
		// }

		// if !read_serial(&ser) {
		// 	time.Sleep(1 * time.Second)
		// 	ser.Write([]byte("\r\n"))
		// }
		// var input string
		// if read_input(&input) {
		// 	// _, err := ser.Write([]byte("print('Hello')\r\n"))
		// 	_, err := ser.Write([]byte(input + "\r\n"))
		// 	if err != nil {
		// 		log.Fatal(err)
		// 	}
		// 	time.Sleep(1 * time.Second)
		// }

		// n, err := ser.Read(buff)
		// if err != nil {
		//     log.Fatal(err)
		//     break
		// }
		// if n == 0 {
		//     break
		// }
		// fmt.Printf("%v", string(buff[:n]))

	}
}
